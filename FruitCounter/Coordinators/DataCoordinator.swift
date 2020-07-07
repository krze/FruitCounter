//
//  DataCoordinator.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation
import Combine


final class DataCoordinator: Subscriber {
    
    private struct Constants {
       static let userDataJSON = "user_data.json"
    }
    
    typealias Input = LogBook
    typealias Failure = Never
    
    let queue = DispatchQueue(label: "io.write")
    
    private var loadCancellable: Cancellable?
    
    /// Fetches the latest data from disk
    /// - Parameters:
    ///   - loadSubscriber: LoadSubscriber that responds to the encoded data
    func fetchLatest(loadSubscriber: DataLoadSubscriber) {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            loadSubscriber.receive(completion: .failure(CocoaError(.fileReadNoPermission)))
            return
        }
        
        let fileURL = documents.appendingPathComponent(Constants.userDataJSON)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            DataLoadPublisher(fileURL: fileURL, queue: queue).receive(subscriber: loadSubscriber)
        }
        else {
            do {
                if let firstFile = try FileManager().contentsOfDirectory(at: documents, includingPropertiesForKeys: nil, options: []).first {
                    DataLoadPublisher(fileURL: firstFile, queue: queue).receive(subscriber: loadSubscriber)
                }
                else {
                    throw CocoaError(.fileReadUnknown)
                }
            } catch let error {
                loadSubscriber.receive(completion: .failure(error))
            }
        }
    }
    
    // MARK: - Subscriber
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: Input) -> Subscribers.Demand {
        print("Received input: \(input)")
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Can't access documents.")
            return .none
        }
        
        if let encodedData = try? JSONEncoder().encode(input) {
            save(data: encodedData, fileName: Constants.userDataJSON, directory: documents)
        }
        
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion: \(completion)")
    }
    
    private func save(data: Data, fileName: String, directory: URL) {
        queue.sync {
             do {
                 try data.write(to: directory.appendingPathComponent(fileName))
             }
             catch let error {
                 print("Save failed")
                 print(error)
                 return
             }
            
        }
    }
    
    private func delete(directory: URL, fileName: String) {
        queue.sync {
            do {
                try FileManager().removeItem(at: directory.appendingPathComponent(fileName))
            }
            catch let error {
                print(error)
                return
            }
        }
    }

}

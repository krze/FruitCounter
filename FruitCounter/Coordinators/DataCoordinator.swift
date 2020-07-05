//
//  DataCoordinator.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/3/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Foundation
import Combine

final class LoadSubscriber: Subscriber {
    typealias Input = UInt8
    typealias Failure = Never
    
    var completion: (UInt8) -> Void
    
    init(onLoad: @escaping (UInt8) -> Void){
        self.completion = onLoad
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.max(1))
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        completion(input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) { }

}

final class DataCoordinator: Subscriber {
    
    typealias Input = LogBook
    typealias Failure = Never
    
    let queue = DispatchQueue(label: "io.write")
    
    private var previousUsername: String?
    private var loadCancellable: Cancellable?
    
    /// Fetches the latest data from disk
    /// - Parameters:
    ///   - userName: Optional username, if any.
    ///   - loadSubscriber: LoadSubscriber that responds to the encoded data
    func fetchLatest(userName: String?, loadSubscriber: LoadSubscriber) {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Can't access documents.")
            return
        }
        
        queue.async {
            if let userName = userName {
                let filename = "\(userName).json"
                do {
                    try Data(contentsOf: documents.appendingPathComponent(filename))
                        .publisher
                        .receive(on: DispatchQueue.main)
                        .subscribe(loadSubscriber)
                }
                catch let error {
                    print(error)
                }
            }
            else {
                guard let path = try? FileManager().contentsOfDirectory(at: documents, includingPropertiesForKeys: nil, options: []).first else {
                    return
                }

                do {
                    try Data(contentsOf: path)
                        .publisher
                        .receive(on: DispatchQueue.main)
                        .subscribe(loadSubscriber)
                }
                catch let error {
                    print(error)
                }
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
        
        if previousUsername != nil && previousUsername != input.userName,
            let previousUsername = previousUsername {
            delete(userName: previousUsername, directory: documents)
        }
        
        if let encodedData = try? JSONEncoder().encode(input) {
            save(data: encodedData, userName: input.userName, directory: documents)
        }
        
        return .none
    }

    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion: \(completion)")
    }
    
    private func save(data: Data, userName: String, directory: URL) {
        queue.sync {
            let filename = "\(userName).json"

             do {
                 try data.write(to: directory.appendingPathComponent(filename))
             }
             catch let error {
                 print("Save failed")
                 print(error)
                 return
             }
            
            previousUsername = userName
        }
    }
    
    private func delete(userName: String, directory: URL) {
        queue.sync {
            let filename = "\(userName).json"
            
            do {
                try FileManager().removeItem(at: directory.appendingPathComponent(filename))
            }
            catch let error {
                print(error)
                return
            }
        }
    }

}

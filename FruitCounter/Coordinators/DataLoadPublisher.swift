//
//  DataLoadPublisher.swift
//  FruitCounter
//
//  Created by Ken Krzeminski on 7/7/20.
//  Copyright © 2020 Ken Krzeminski. All rights reserved.
//

import Combine
import Foundation

final class DataLoadSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
    
    private let fileURL: URL
    private var subscriber: S?
    private let queue: DispatchQueue
    
    init(fileURL: URL, subscriber: S, queue: DispatchQueue) {
        self.fileURL = fileURL
        self.subscriber = subscriber
        self.queue = queue
        loadFile()
    }
    
    func request(_ demand: Subscribers.Demand) {
        // TODO: Demand switching if necessary
    }
    
    func cancel() {
        subscriber = nil
    }
    
    private func loadFile() {
        do {
            let data = try Data(contentsOf: fileURL)
           _ = subscriber?.receive(data)
        }
        catch let error {
            subscriber?.receive(completion: Subscribers.Completion.failure(error))
        }
    }
    
}

struct DataLoadPublisher: Publisher {
    
    typealias Output = Data
    typealias Failure = Error
    
    let fileURL: URL
    let queue: DispatchQueue
    
    init(fileURL: URL, queue: DispatchQueue = DispatchQueue(label: "io.readWrite")) {
        self.fileURL = fileURL
        self.queue = queue
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, DataLoadPublisher.Failure == S.Failure, DataLoadPublisher.Output == S.Input {
        let subscription = DataLoadSubscription(fileURL: fileURL, subscriber: subscriber, queue: queue)
        subscriber.receive(subscription: subscription)
    }
    
}

final class DataLoadSubscriber: Subscriber {
    typealias Input = Data
    typealias Failure = Error
    
    var completion: (Result<Data, Error>) -> Void
    
    init(onLoad: @escaping (Result<Data, Error>) -> Void) {
        self.completion = onLoad
    }
    
    func receive(subscription: Subscription) {
        subscription.request(.max(1))
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        completion(Result.success(input))
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            self.completion(Result.failure(error))
        default:
            return
        }
    }

}

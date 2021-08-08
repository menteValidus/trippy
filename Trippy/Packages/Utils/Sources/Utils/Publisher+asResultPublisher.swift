//
//  Publisher+asResultPublisher.swift
//  
//
//  Created by Denis Cherniy on 08.08.2021.
//

import Combine

public extension Publisher {
    
    func asResultPublisher() -> ResultPublisher<Output, Failure> {
        self.map {
            Result.success($0)
        }
        .catch {
            Just(Result.failure($0))
        }
        .eraseToAnyPublisher()
    }
}

//
//  Typealiases.swift
//  
//
//  Created by Denis Cherniy on 27.05.2021.
//

import Foundation
import Combine

public typealias Callback = () -> Void

public typealias ViewModel = ObservableObject

public typealias ResultPublisher<Success, Error: Swift.Error> = AnyPublisher<Result<Success, Error>, Never>

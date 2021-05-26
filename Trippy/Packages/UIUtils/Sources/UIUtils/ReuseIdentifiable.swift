//
//  ReuseIdentifiable.swift
//  
//
//  Created by Denis Cherniy on 26.05.2021.
//

public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: self) + "ReuseIdentifier"
    }
}

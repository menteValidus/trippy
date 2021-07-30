//
//  LinkedListIndex.swift
//  
//
//  Imported from https://github.com/raywenderlich/swift-algorithm-club on 28.05.2021.
//


/// Custom index type that contains a reference to the node at index 'tag'
public struct LinkedListIndex<T>: Comparable {
    fileprivate let node: LinkedList<T>.LinkedListNode<T>?
    fileprivate let tag: Int
    
    public static func==<T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return (lhs.tag == rhs.tag)
    }
    
    public static func< <T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return (lhs.tag < rhs.tag)
    }
}

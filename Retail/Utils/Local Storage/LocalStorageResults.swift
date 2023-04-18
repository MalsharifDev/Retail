//
//  LocalStorageResults.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Foundation

final class LocalStorageResults<E: StorableBase> {

    typealias StorageResultsCollectionChangeCallback = (StorageResultsCollectionChange<LocalStorageResults<E>>) -> Void
    typealias DidObserveCallback = (@escaping StorageResultsCollectionChangeCallback) -> StorageNotificationToken?

    var didObserveHandler: DidObserveCallback?

    var result: Array<StorableBase>

    init(result: Array<StorableBase>) {
        self.result = result
    }
}

// MARK: - Collection

extension LocalStorageResults: Collection {

    typealias Index = Int
    
    var startIndex: Index {
        result.startIndex
    }
    
    var endIndex: Index {
        result.endIndex
    }

    var first: Element? {
        result.first as? Element
    }
    
    var last: Element? {
        result.last as? Element
    }
    
    subscript(position: Int) -> E {
        result[position] as! E
    }
    
    func index(after i: Int) -> Int {
        result.index(after: i)
    }

	var count: Int {
        result.count
	}
}

// MARK: - String Convertible

extension LocalStorageResults: CustomStringConvertible {
    public var description: String {
        Array(self).map { String(describing: $0) }.joined(separator: "\n")
    }
}

// MARK: - Sorting

extension LocalStorageResults {

	public func sorted<Value: Comparable>(by keyPath: KeyPath<E, Value>, ascending: Bool = true) -> LocalStorageResults<E> {
		let r = result.map { $0 as! E }

		if ascending {
			result = r.sorted(by: { $0[keyPath: keyPath]  <  $1[keyPath: keyPath] })
		} else {
			result = r.sorted(by: { $0[keyPath: keyPath]  >  $1[keyPath: keyPath] })
		}

		return self
	}

	public func sorted(by keyPath: KeyPath<E, Bool>, ascending: Bool = true) -> LocalStorageResults<E> {
		let r = result.map { $0 as! E }

		if ascending {
			result = r.sorted(by: { $0[keyPath: keyPath] && !$1[keyPath: keyPath] })
		} else {
			result = r.sorted(by: { !$0[keyPath: keyPath] && $1[keyPath: keyPath] })
		}

		return self
	}
}


// MARK: - Notifications

extension LocalStorageResults {
    /**
     Registers a block to be called each time the collection changes.

     - parameter block: The block to be called whenever a change occurs.
     - returns: A token which must be held for as long as you want updates to be delivered.
     */
    func observe(_ block: @escaping (StorageResultsCollectionChange<LocalStorageResults<E>>) -> Void) -> StorageNotificationToken? {
        didObserveHandler? { [weak self] change in
            switch change {
            case .update(let new, deletions: _, insertions: _, modifications: _):
                self?.result = Array(new)

            default: break
            }

            block(change)
        }
    }
}

enum StorageResultsCollectionChange<CollectionType> {
    /**
     `.initial` indicates that the initial run of the query has completed (if
     applicable), and the collection can now be used without performing any
     blocking work.
     */
    case initial(CollectionType)

    /**
     `.update` indicates that a write transaction has been committed which
     either changed which objects are in the collection, and/or modified one
     or more of the objects in the collection.

     All three of the change arrays are always sorted in ascending order.

     - parameter deletions: The indices in the previous version of the collection which were removed from this one.
     - parameter insertions: The indices in the new collection which were added in this version.
     - parameter modifications: The indices of the objects in the new collection which were modified in this version.
     */
    case update(CollectionType, deletions: [Int], insertions: [Int], modifications: [Int])

    /**
     If an error occurs, notification blocks are called one time with a `.error`
     result and an `NSError` containing details about the error.
     */
    case error(Error)
}

final class StorageNotificationToken {

	private let underlying: Any

	var onInvalidateHandler: (() -> Void)?

	public init(_ underlying: Any) {
		self.underlying = underlying
	}

	public func invalidate() {
		onInvalidateHandler?()
	}
}

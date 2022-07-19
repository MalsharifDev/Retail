//
//  LocalStorage.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Unrealm

typealias StorableEnum = RealmableEnum

protocol StorableBase { }

protocol Storable: StorableBase {
	static func all(in storage: LocalStorage) -> LocalStorageResults<Self>
	func store(in storage: LocalStorage)
	func delete(from storage: LocalStorage)
}

protocol LocalStorage {
	func write<T: Storable>(value: T)
	func write<T: Storable>(values: [T])
	func read<T: Storable>(_ type: T.Type) -> LocalStorageResults<T>
	func read<T: Storable, KeyType>(_ type: T.Type, forPrimaryKey key: KeyType) -> T?
	func delete<T: Storable>(value: T)
	func delete<T: Storable>(values: [T])

    func register(storables: StorableBase.Type..., storableEnums: StorableEnum.Type...)
}

extension Storable {

    static func all(in storage: LocalStorage = RealmStorage.default) -> LocalStorageResults<Self> {
        storage.read(Self.self)
    }

    func store(in storage: LocalStorage = RealmStorage.default) {
        storage.write(value: self)
    }

    func delete(from storage: LocalStorage = RealmStorage.default) {
        storage.delete(value: self)
    }
}

//
//  RealmStorage.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import Unrealm
import Realm

typealias Realmable = Unrealm.Realmable

class RealmStorage: LocalStorage {

    static let `default` = RealmStorage()

    private init() { }

    private var config: Realm.Configuration = .defaultConfiguration

    private lazy var realm: Realm = {
        try! Realm(configuration: config)
    }()

    public func write<T>(value: T) where T: Storable {
        guard let value = value as? Realmable else { return }

        try! realm.write {
            realm.add(value, update: .all)
        }
    }

    public func write<T>(values: [T]) where T: Storable {
        values.forEach { write(value: $0) }
    }

    public func read<T>(_ type: T.Type) -> LocalStorageResults<T> where T: Storable {
        guard let type = type as? Realmable.Type else { return LocalStorageResults(result: []) }

        let rlmResult = realm.anyObjectArray(type)
        let result: LocalStorageResults<T> = LocalStorageResults(result: Array(rlmResult).compactMap { $0 as? T })

        result.didObserveHandler = { callback in
            let token = rlmResult.observe { change in
                switch change {
                case .initial(let results):
                    let newValue = LocalStorageResults<T>(result: Array(results).compactMap { $0 as? T })

                    callback(.initial(newValue))

                case .update(let results, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                    let newValue = LocalStorageResults<T>(result: Array(results).compactMap { $0 as? T })

                    callback(.update(newValue, deletions: deletions, insertions: insertions, modifications: modifications))

                case .error(let error):
                    callback(.error(error))
                }
            }

            let storageNotificationToken = StorageNotificationToken(token)

            storageNotificationToken.onInvalidateHandler = {
                token.invalidate()
            }

            return storageNotificationToken
        }

        return result
    }

    public func read<T, KeyType>(_ type: T.Type, forPrimaryKey key: KeyType) -> T? where T: Storable {
        guard let type = type as? Realmable.Type else { return nil }

        return realm.anyObject(type, forPrimaryKey: key) as? T
    }

    public func delete<T>(value: T) where T: Storable {
        guard let value = value as? Realmable else { return }

        try! realm.write {
            realm.delete(value)
        }
    }

    public func delete<T>(values: [T]) where T: Storable {
        values.forEach { delete(value: $0) }
    }

    func register(storables: StorableBase.Type..., storableEnums: StorableEnum.Type...) {
        let realmableTypes = storables.compactMap { $0 as? RealmableBase.Type }

        Realm.registerRealmables(realmableTypes, enums: storableEnums)

        let objectTypes = realmableTypes.compactMap { $0.objectType() }
        let config = Realm.Configuration(
            fileURL: URL(fileURLWithPath: RLMRealmPathForFile("Retail.realm")),
            schemaVersion: 1,
            migrationBlock: nil,
            deleteRealmIfMigrationNeeded: true,
            objectTypes: objectTypes
        )

        self.config = config
    }
}

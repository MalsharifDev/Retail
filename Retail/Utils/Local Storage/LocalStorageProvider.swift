//
//  LocalStorageProvider.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/18/22.
//

import Foundation

struct LocalStorageProvider {

    enum ProviderType {
        case realm
        case coredata // possible alternative
        case sqlite // possible alternative
    }

    static func provide(type: ProviderType) -> LocalStorage {
        switch type {
        case .realm: return RealmStorage.default
        default: fatalError()
        }
    }
}

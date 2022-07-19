//
//  Retail.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import SwiftUI
import Unrealm

class AppDelegate: NSObject, UIApplicationDelegate {

    static var orientationLock = UIInterfaceOrientationMask.all

    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        AppDelegate.orientationLock
    }
}

@main
struct Retail: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    static let localStorage = LocalStorageProvider.provide(type: .realm)

    init() {
        registerLocalStorageTypes()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }

    private func registerLocalStorageTypes() {
        Retail.localStorage.register(
            storables: Landing.self, Product.self, Wishlist.self, Cart.self,
            storableEnums: Badge.self
        )
    }
}

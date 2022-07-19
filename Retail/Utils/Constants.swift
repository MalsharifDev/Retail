//
//  Constants.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/14/22.
//

import Foundation

typealias Constant = String
typealias SFSymbolName = String

extension Constant {
    static let productLandingServiceURLString = "https://run.mocky.io/v3/5c138271-d8dd-4112-8fb4-3adb1b7f689e"
}

extension SFSymbolName {
    // Wishlist Buttons
    static let bookmark = "bookmark"
    static let bookmarkFill = "bookmark.fill"

    // UI Buttons
    static let trash = "trash"
    static let arrowCounterClockwise = "arrow.counterclockwise"

    // Navigation Buttons
    static let xmark = "xmark"
    static let arrowBackward = "arrow.backward"
}

enum AppView {
    enum ProductDetail {
        static let addToBagButtonLabel = "ADD TO BAG"
    }

    enum Wishlist {
        static let navBarTitle = "WISHLIST"
    }

    enum WishlistItem {
        static let removeButtonLabel = "Remove"
    }

    enum ProductLanding {
        static let networkErrorMessage = "A network error has occurred, please try again."
    }
}


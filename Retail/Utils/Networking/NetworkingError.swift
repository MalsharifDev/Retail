//
//  NetworkingError.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import Foundation

enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown

    var errorDescription: String? {
        switch self {
        case .badURLResponse(let url):
            return "[🔥] Bad response from URL: \(url)"

        case .unknown:
            return "[⚠️] Unknown error occurred."
        }
    }
}

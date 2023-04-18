//
//  NetworkingManager.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import Foundation
import Combine

class NetworkingManager {

    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .tryMap { try handleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            throw NetworkingError.badURLResponse(url: url)
        }

        return output.data
    }
}

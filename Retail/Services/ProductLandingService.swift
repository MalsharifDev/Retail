//
//  ProductLandingService.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import Foundation
import Combine

class ProductLandingService {

    enum CompletionState {
        case success
        case failure
    }

    // Published Properties
    @Published var landing = Landing(title: "", currency: "", items: [])
    @Published var completionState: CompletionState = .success

    // Subscriber Properties
    private var landingSubscription: AnyCancellable?

    // MARK: - Init

    init() {
        getLanding()
    }

    // MARK: - Networking

    private func getLanding() {
        guard let productListURL = URL(string: .productLandingServiceURLString) else { return }
        
        landingSubscription = NetworkingManager.download(url: productListURL)
            .decode(type: Landing.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished: self?.completionState = .success
                    case .failure(_): self?.completionState = .failure
                    }
                },
                receiveValue: { [weak self] landing in
                    self?.landing = landing
                    self?.landingSubscription?.cancel()
                }
            )
    }
}

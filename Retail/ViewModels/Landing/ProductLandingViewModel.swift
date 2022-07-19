//
//  ProductLandingViewModel.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import Foundation
import Combine

final class ProductLandingViewModel: ObservableObject {

    enum ViewState {
        case ready
        case loading
        case error
    }

    // Local Storage
    private let localStorage = Retail.localStorage

    // Service
    private let productLandingService = ProductLandingService()

    // Observer properties
    private var cancellables = Set<AnyCancellable>()
    private var storageNotificationToken: StorageNotificationToken?

    // Published data properties
    @Published var productList: [Product] = []
    @Published var title = ""
    @Published var currency = ""

    // Published UI properties
    @Published var viewState: ViewState = .loading
    @Published var shouldShowWishlistView = false

    // Convenience property
    private var isWishlistEmpty: Bool {
        Wishlist.all(in: self.localStorage).first?.items.first == nil
    }

    // MARK: - Init

    init() {
        getLanding()
        observeWishlist()
    }

    // MARK: - Data Refresh

    func getLanding() {
        let storedLanding = Landing.all(in: localStorage)

        guard storedLanding.isEmpty == true else {
            viewState = .ready

            productList = storedLanding.first?.items ?? []
            title = storedLanding.first?.title ?? ""
            currency = storedLanding.first?.currency ?? ""

            return
        }

        viewState = .loading

        productLandingService.$landing
            .sink { [weak self] landing in
                guard let self = self, !landing.isEmpty else { return }

                self.viewState = .ready

                self.title = landing.title
                self.currency = landing.currency
                self.productList = landing.items

                landing.store(in: self.localStorage)
            }
            .store(in: &cancellables)

        productLandingService.$completionState
            .sink { [weak self] completionState in
                switch completionState {
                case .success: break
                case .failure: self?.viewState = .error
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Private

    private func observeWishlist() {
        storageNotificationToken = Wishlist.all(in: localStorage).observe { [weak self] _ in
            guard let self = self else { return }

            self.shouldShowWishlistView = !self.isWishlistEmpty
        }
    }
}

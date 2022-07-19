//
//  WishListView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/17/22.
//

import SwiftUI

struct WishListView: View {

    @ObservedObject var viewModel: WishlistViewModel

    @Environment(\.presentationMode) private var mode
    @State private var shouldShowDetailView = false

    var body: some View {
        NavigationView {
            List(viewModel.wishlist.items) { item in
                let wishlistItemViewModel = WishlistItemViewModel(
                    item: item,
                    currency: viewModel.currency
                )

                WishlistItemView(viewModel: wishlistItemViewModel)
                    .listRowBackground(Color.clear)
            }
            .animation(.default, value: viewModel.wishlist.items)
            .listStyle(.plain)
            .buttonStyle(.plain)
            .navigationBarTitle(viewModel.title, displayMode: .inline)
            .toolbar {
                SFSymbolButton(symbolName: .xmark) {
                    mode.wrappedValue.dismiss()
                }
            }
        }
        .onChange(of: viewModel.wishlist.items) { newValue in
            guard viewModel.shouldDismiss else { return }

            mode.wrappedValue.dismiss()
        }
    }
}

//
//  ProductLandingView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/16/22.
//

import SwiftUI

struct ProductLandingView: View {
    
    @ObservedObject var viewModel = ProductLandingViewModel()

    @State private var isPresented = false

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]

    var body: some View {
        switch viewModel.viewState {
        case .ready: productGridView
        case .loading: ProgressView()
        case .error: errorView
        }
    }
}

extension ProductLandingView {

    private var errorView: some View {
        VStack {
            Text(AppView.ProductLanding.networkErrorMessage)

            SFSymbolButton(symbolName: .arrowCounterClockwise) {
                viewModel.getLanding()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightGray)
        .foregroundColor(.gray)
        .ignoresSafeArea()
    }

    private var productGridView: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(viewModel.productList) { item in
                        let productViewModel = ProductViewModel(item: item, currency: viewModel.currency)

                        ProductView(viewModel: productViewModel)
                    }
                }
                .padding()
                .navigationBarTitle(viewModel.title, displayMode: .inline)
                .toolbar {
                    toolbar
                }
            }
        }
        .navigationBarHidden(true)
    }

    private var toolbar: some View {
        ZStack {
            let wishlistViewModel = WishlistViewModel(currency: viewModel.currency)
            let color: Color = !viewModel.shouldShowWishlistView ? .gray : .black

            SFSymbolButton(symbolName: .bookmark, color: color) {
                if viewModel.shouldShowWishlistView {
                    isPresented.toggle()
                }
            }
            .disabled(!viewModel.shouldShowWishlistView)
            .fullScreenCover(
                isPresented: $isPresented,
                content: {
                    WishListView(viewModel: wishlistViewModel)
                }
            )
        }
    }
}

struct ProductLandingView_Previews: PreviewProvider {
    static var previews: some View {
        ProductLandingView()
    }
}

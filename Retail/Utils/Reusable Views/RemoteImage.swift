//
//  ImageView.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/15/22.
//

import SwiftUI

/**
    An image of type `View` that takes a URL `String` to render an image. This may become obsolete once the minimum support requirement for iOS 14 drops to be replaced by `AsyncImage` introduced for iOS 15 and up.
*/
struct RemoteImage: View {

    private enum LoadState {
        case loading
        case success
        case failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { [self] data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    state = .success
                } else {
                    state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
            .resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    private var loadedImage: Image {
        switch loader.state {
        case .loading:
            return loading

        case .failure:
            return failure

        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }

    var size: CGSize
    
    init(
        from url: String,
        size: CGSize = CGSize(width: 100, height: 100),
        loading: Image = Image(systemName: "photo"),
        failure: Image = Image(systemName: "multiply.circle")
    ) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.size = size
        self.loading = loading
        self.failure = failure
    }

    var body: some View {
        loadedImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
    }
}

//
//  SFSymbolButton.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/14/22.
//

import SwiftUI

/**
    A button of type `View` that uses an SF Symbol name to render an icon `Image` as its label.
*/
struct SFSymbolButton: View {

    typealias Action = () -> Void

    enum Size {
        case small
        case medium
        case large
    }

    var symbolName: SFSymbolName
    var size: Size = .medium
    var color: Color = .black
    var action: Action

    private var buttonSize: CGFloat {
        switch size {
        case .small: return 10
        case .medium: return 20
        case .large: return 30
        }
    }

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: symbolName)
                .foregroundColor(color)
                .font(.system(size: buttonSize))
        }
    }
}

//
//  BadgeOverlay.swift
//  Retail
//
//  Created by Mohammad Alsharif on 7/18/22.
//

import SwiftUI

struct BadgeOverlay: View {

    let badges: [Badge]

    var spacing: CGFloat = 5
    var padding: CGFloat = 7
    var font: Font = .system(size: 12)
    var height: CGFloat = 25

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: spacing) {
                if badges.contains(.kidsUnisex) {
                    BadgeView(
                        title: Badge.kidsUnisex.rawValue,
                        font: font,
                        height: height
                    )
                }

                HStack(spacing: spacing) {
                    if badges.contains(.new) {
                        BadgeView(
                            title: Badge.new.rawValue,
                            font: font,
                            height: height
                        )
                    }

                    if badges.contains(.sale) {
                        BadgeView(
                            title: Badge.sale.rawValue,
                            font: font,
                            height: height
                        )
                    }
                }
            }
            .padding(padding)
        }
    }
}

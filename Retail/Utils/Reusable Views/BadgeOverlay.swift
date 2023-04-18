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
                    badgeView(for: .kidsUnisex)
                }

                HStack(spacing: spacing) {
                    if badges.contains(.new) {
                        badgeView(for: .new)
                    }

                    if badges.contains(.sale) {
                        badgeView(for: .sale)
                    }
                }
            }
            .padding(padding)
        }
    }
}

extension BadgeOverlay {

    private func badgeView(for badge: Badge) -> some View {
        BadgeView(
            title: badge.rawValue,
            font: font,
            height: height
        )
    }
}

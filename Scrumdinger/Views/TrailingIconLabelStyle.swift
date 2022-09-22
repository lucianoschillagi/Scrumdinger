//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Luko on 20/09/2022.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

// Label Style Protocol Extension
extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}


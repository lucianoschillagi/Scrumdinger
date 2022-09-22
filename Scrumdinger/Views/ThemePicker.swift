//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Luko on 22/09/2022.
//

import SwiftUI

struct ThemePicker: View {
    // Try to maintain a single source of truth for every piece of data in your app. Instead of creating a new source of truth for the theme picker, you’ll use a binding that references a theme structure defined in the parent view.
    @Binding var selection: Theme

    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}

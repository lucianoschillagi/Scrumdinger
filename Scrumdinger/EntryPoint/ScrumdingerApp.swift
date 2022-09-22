//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Luko on 19/09/2022.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.sampleData)
            }
        }
    }
}

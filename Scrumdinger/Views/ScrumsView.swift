//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Luko on 20/09/2022.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum] // plural
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
             }
         }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("New scrum")
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}

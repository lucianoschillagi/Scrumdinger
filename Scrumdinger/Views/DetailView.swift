//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Luko on 21/09/2022.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(data.lengthInMinutes) minutes")
                }
                /*
                 Add accessibilityElement(children:) to the HStack to combine the Label and Text elements for accessibility users.
                 VoiceOver then reads the two elements as one statement, for example, “Length, 10 minutes.” Without the modifier, VoiceOver users have to swipe again between each element.
                 */
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(data.theme.name)
                        .padding(4)
                        .foregroundColor(data.theme.accentColor)
                        .background(data.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
                Section(header: Text("Attendees")) {
                    ForEach(data.attendees) { attendee in
                        Label(attendee.name, systemImage: "person")                    }
                }
            }
        }
        .navigationTitle(data.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = scrum.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(data.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                            }
                        }
                }
            }
        }
    }
}

// MARK: - Previews
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(scrum: DailyScrum.sampleData[0])    }
}

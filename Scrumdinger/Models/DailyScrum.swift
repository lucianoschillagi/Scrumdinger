//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Luko on 19/09/2022.
//

import Foundation

struct DailyScrum: Identifiable {
    let id: UUID // stable indentity
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    
    /// Info about the attendees
    struct Attendee: Identifiable { // nested type
        let id: UUID
        var name: String
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    /// Info about a specific scrum
    struct Data { // nested type with default values
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
}

// sample data to prototype
extension DailyScrum {
    static let sampleData: [DailyScrum] = [
        DailyScrum(title: "Design",
                 attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                 lengthInMinutes: 10,
                 theme: .yellow),
        DailyScrum(title: "App Dev",
                 attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
                 lengthInMinutes: 5,
                 theme: .orange),
        DailyScrum(title: "Web Dev",
                 attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
                 lengthInMinutes: 5,
                 theme: .poppy)
    ]
}

//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Luko on 13/10/2022.
//

import SwiftUI

struct MeetingHeaderView: View {
    
    // MARK: - Properties
    let secondsElapsed: Int
    let secondsRemaining: Int
    private var totalSeconds: Int {
          secondsElapsed + secondsRemaining
      }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
          secondsRemaining / 60
    }
    // MARK: - Render
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed").font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Seconds Remaining").font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                }
            }
        }
        // Accesibility modifiers
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
    }
}

// MARK: - Previews
struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180)
            .previewLayout(.sizeThatFits)
    }
}


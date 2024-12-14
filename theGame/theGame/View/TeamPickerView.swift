//
//  TeamPickerView.swift
//  theGame
//
//  Created by Pavlo Snizhko on 21.11.2024.
//

import SwiftUI

struct TeamPickerView: View {
    let teams: [Team]
    @Binding var selectedTeam: Team?
    var otherTeam: Team?

    var body: some View {
        NavigationView {
            List(teams) { team in
                Button(action: {
                    if team != otherTeam {
                        selectedTeam = team
                    }
                }) {
                    HStack {
                        Text(team.title)
                        if team == selectedTeam {
                            Spacer()
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .disabled(team == otherTeam)
                .foregroundColor(team == otherTeam ? .gray : .primary)
            }
            .navigationTitle("Select a Team")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        selectedTeam = nil
                    }
                }
            }
        }
    }
}

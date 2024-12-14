//
//  MatchView.swift
//  theGame
//
//  Created by Pavlo Snizhko on 20.11.2024.
//

import SwiftUI

struct MatchView: View {
    @EnvironmentObject var viewModel: TeamsViewModel
    @State private var activePicker: PickerType?

    enum PickerType: Int, Identifiable {
        case team1, team2

        var id: Int { rawValue }
    }

    var body: some View {
        VStack(spacing: 10) {
            Text("Match")
                .font(.system(size: 17, weight: .bold, design: .default))

            HStack(spacing: 5) {
                Button(action: {
                    activePicker = .team1
                }) {
                    Text(viewModel.selectedTeam1?.title ?? "Select Team 1")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }

                Text(":")
                    .font(.system(size: 17, weight: .bold, design: .default))

                Button(action: {
                    activePicker = .team2
                }) {
                    Text(viewModel.selectedTeam2?.title ?? "Select Team 2")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .sheet(item: $activePicker) { pickerType in
            TeamPickerView(
                teams: viewModel.teams,
                selectedTeam: pickerType == .team1 ? $viewModel.selectedTeam1 : $viewModel.selectedTeam2,
                otherTeam: pickerType == .team1 ? viewModel.selectedTeam2 : viewModel.selectedTeam1
            )
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView()
            .environmentObject(TeamsViewModel())
    }
}

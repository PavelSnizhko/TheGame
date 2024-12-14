//
//  TeamsView.swift
//  theGame
//
//  Created by Pavlo Snizhko on 20.11.2024.
//

import SwiftUI

struct TeamsView: View {
    @EnvironmentObject var viewModel: TeamsViewModel

    @State private var showAddTeamAlert = false
    @State private var newTeamName = ""

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Teams")
                    .font(.system(size: 17, weight: .bold, design: .default)) // SF Pro Text Bold 17pt
                Spacer()
                Button(action: {
                    showAddTeamAlert = true
                }) {
                    Image(systemName: "plus.circle") // Placeholder; replace with your image
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal) // Only horizontal padding

            List {
                ForEach(viewModel.teams) { team in
                    HStack {
                        Text(team.title)
                            .font(.system(size: 17, weight: .regular, design: .default))
                        Spacer()
                        Text("Games: \(team.numberOfGames)")
                            .font(.system(size: 17, weight: .regular, design: .default))
                    }
                }
                .onDelete(perform: viewModel.removeTeam)
            }
            .scrollContentBackground(.hidden) // Smooth scrolling

            Spacer()
        }
        .padding(.horizontal) // Keep horizontal padding for symmetry
        // Alert for adding new team
        .alert("Add Team", isPresented: $showAddTeamAlert, actions: {
            TextField("Enter team name", text: $newTeamName)
            Button("Add") {
                guard !newTeamName.isEmpty else { return }
                viewModel.addTeam(with: newTeamName)
                newTeamName = ""
            }
            Button("Cancel", role: .cancel) {}
        })
    }
}

struct TeamsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsView()
            .environmentObject(TeamsViewModel())
    }
}

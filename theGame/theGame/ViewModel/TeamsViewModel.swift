//
//  TeamsViewModel.swift
//  theGame
//
//  Created by Pavlo Snizhko on 20.11.2024.
//

import Foundation

class TeamsViewModel: ObservableObject {
    @Published var teams: [Team] = []
    @Published var selectedTeam1: Team?
    @Published var selectedTeam2: Team?

    func addTeam(with name: String) {
        let newTeam = Team(title: name)
        teams.append(newTeam)
    }

    func removeTeam(at offsets: IndexSet) {
        teams.remove(atOffsets: offsets)
    }

    func saveMatchResult(team1Score: Int, team2Score: Int) {
        guard let team1 = selectedTeam1, let team2 = selectedTeam2 else { return }

        // Update scores and stats for both teams
        if let index1 = teams.firstIndex(where: { $0.id == team1.id }) {
            teams[index1].numberOfGames += 1
            teams[index1].scoredGoals += team1Score
            teams[index1].missingGoals += team2Score
            teams[index1].score += (team1Score > team2Score ? 3 : team1Score == team2Score ? 1 : 0)
        }

        if let index2 = teams.firstIndex(where: { $0.id == team2.id }) {
            teams[index2].numberOfGames += 1
            teams[index2].scoredGoals += team2Score
            teams[index2].missingGoals += team1Score
            teams[index2].score += (team2Score > team1Score ? 3 : team2Score == team1Score ? 1 : 0)
        }
    }
}


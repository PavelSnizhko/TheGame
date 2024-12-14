//
//  Team.swift
//  theGame
//
//  Created by Pavlo Snizhko on 20.11.2024.
//

import Foundation

struct Team: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var numberOfGames: Int = 0
    var score: Int = 0
    var missingGoals: Int = 0
    var scoredGoals: Int = 0

    var matchHistory: [MatchResult] = []
}

struct MatchResult: Identifiable, Equatable {
    let id = UUID()
    var opponent: String
    var teamScore: Int
    var opponentScore: Int
}

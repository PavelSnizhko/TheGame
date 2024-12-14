//
//  GameModeView.swift
//  theGame
//
//  Created by Pavlo Snizhko on 21.11.2024.
//

import SwiftUI

struct GameModeView: View {
    @Binding var gameTime: Double
    @Binding var breakTime: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Game Mode")
                .font(.system(size: 17, weight: .bold))

            VStack(spacing: 0) {
                // First Row: Game Duration
                GameModeRow(
                    leadingImage: "clock",
                    title: "Game Duration",
                    subtitle: "Enter minutes to play",
                    totalSeconds: $gameTime
                )
                Divider() // Divider between rows

                // Second Row: Break Duration
                GameModeRow(
                    leadingImage: "pause.circle",
                    title: "Break Duration",
                    subtitle: "Enter minutes for break",
                    totalSeconds: $breakTime
                )
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

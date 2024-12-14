//
//  ContentView.swift
//  theGame
//
//  Created by Pavlo Snizhko on 20.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TeamsViewModel()
    @State private var gameTime = 0.0
    @State private var breakTime = 0.0
    @State private var isTimerPresented = false

    var body: some View {
        VStack(spacing: 30) {
            TeamsView()
                .frame(height: 176)
            MatchView()
                .frame(height: 78)
            GameModeView(gameTime: $gameTime, breakTime: $breakTime)
            Button(action: startGame) {
                Text("Start Game")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isTimerPresented) { [gameTime, breakTime] in
            TimerView(gameTime: gameTime, breakTime: breakTime)
        }
        .environmentObject(viewModel)
    }

    func startGame() {
        isTimerPresented = true
    }
}

#Preview {
    ContentView()
}

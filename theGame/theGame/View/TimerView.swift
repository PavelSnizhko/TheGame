//
//  TimerView.swift
//  theGame
//
//  Created by Pavlo Snizhko on 22.11.2024.
//

import SwiftUI
import AVFoundation


struct TimerView: View {
    @EnvironmentObject var viewModel: TeamsViewModel
    @StateObject private var timerViewModel: TimerViewModel

    @State private var team1Score: Int = 0
    @State private var team2Score: Int = 0

    init(gameTime: Double, breakTime: Double) {
        _timerViewModel = StateObject(wrappedValue: TimerViewModel(gameTime: gameTime, breakTime: breakTime))
    }

    var body: some View {
        VStack(spacing: 20) {
            // Title (First Half, Break Time, etc.)
            Text(timerViewModel.title)
                .font(.title)
                .bold()

            // Timer Display
            Text(formatTime(timerViewModel.timeRemaining))
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .padding()

            // Progress Bar
            ProgressView(value: timerViewModel.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .padding()

            // Timer Controls
            HStack(spacing: 20) {
                Button(action: {
                    if timerViewModel.isTimerRunning {
                        timerViewModel.pauseTimer()
                    } else {
                        timerViewModel.resumeTimer()
                    }
                }) {
                    Text(timerViewModel.isTimerRunning ? "Pause" : "Start")
                        .font(.title2)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                }

                Button(action: {
                    timerViewModel.resetTimer()
                }) {
                    Text("Reset")
                        .font(.title2)
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(8)
                }
            }

            Divider()

            // Score Tracking
            HStack(spacing: 40) {
                VStack(alignment: .center) {
                    Text(viewModel.selectedTeam1?.title ?? "Team 1")
                        .font(.headline)
                        .padding(.bottom, 5)

                    VStack(alignment: .center) {
                        Text("Score: \(team1Score)")
                        Stepper(value: $team1Score, in: 0...100) {}
                    }
                }

                Text(":")
                    .font(.largeTitle)
                    .bold()

                VStack {
                    Text(viewModel.selectedTeam2?.title ?? "Team 2")
                        .font(.headline)
                        .padding(.bottom, 5)

                    Stepper(value: $team2Score, in: 0...100) {
                        Text("Score: \(team2Score)")
                    }
                }
            }
            .padding()

            Divider()

            // Save Match Result
            Button(action: {
                timerViewModel.pauseTimer()
                viewModel.saveMatchResult(team1Score: team1Score, team2Score: team2Score)
            }) {
                Text("Finish Game")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onReceive(timerViewModel.$isFinished) { isFinished in
            if isFinished {
                viewModel.saveMatchResult(team1Score: team1Score, team2Score: team2Score)
            }
        }
    }

    private func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    TimerView(gameTime: 10, breakTime: 20)
        .environmentObject(TeamsViewModel())
}

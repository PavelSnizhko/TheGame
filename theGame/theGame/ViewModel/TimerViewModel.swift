//
//  TimerViewModel.swift
//  theGame
//
//  Created by Pavlo Snizhko on 23.11.2024.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Double = 0
    @Published var isBreak: Bool = false
    @Published var isTimerRunning: Bool = false
    @Published var isFirstHalf: Bool = true // Tracks whether it's the first half of the game

    @Published var progress: Double = 0

    var gamePart: GamePart = .firstHalf {
        didSet {
            switch gamePart {
            case .firstHalf:
                title = "First Half"
            case .break:
                title = "Break Time"
            case .secondHalf:
                title = "Second Half"
            case .withoutBreak:
                title = "Full game"
            }
        }
    }

    @Published var title: String = "First Half"

    @Published var isFinished: Bool = false

    var gameDurationHalf: Double
    var gameTime: Double

    lazy var halfDurationSec = {
        gameTime / 2
    }()

    private var breakTime: Double
    private var timer: AnyCancellable?

    init(gameTime: Double, breakTime: Double) {
        self.gameTime = gameTime
        self.gameDurationHalf = gameTime / 2 // Half of the game duration in seconds
        self.breakTime = breakTime
        setupTimer()
    }

    func setupTimer() {
        timeRemaining = breakTime == 0 ? gameTime : halfDurationSec
        gamePart = breakTime == 0 ? .withoutBreak : .firstHalf
        runTimer()
    }

    func runTimer() {
        isTimerRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }

    func pauseTimer() {
        isTimerRunning = false
        timer?.cancel()
    }

    func resumeTimer() {
        runTimer()
    }

    private func updateTimer() {
        guard timeRemaining > 0 else {
            timerDidEnd()
            return
        }

        timeRemaining -= 1

        switch gamePart {
        case .firstHalf:
            progress = 1 - timeRemaining / halfDurationSec
        case .break:
            progress = 1 - timeRemaining / breakTime
        case .secondHalf:
            progress = 1 - timeRemaining / halfDurationSec
        case .withoutBreak:
            progress = 1 - timeRemaining / gameTime
        }
    }

    private func timerDidEnd() {
        timer?.cancel()
        isTimerRunning = false

        switch gamePart {
        case .withoutBreak:
            playSound(for: .timerEnded)
            isFinished = true
        case .firstHalf:
            gamePart = .break
            timeRemaining = breakTime
            playSound(for: .breakStarted)
        case .break:
            gamePart = .secondHalf
            timeRemaining = halfDurationSec
            playSound(for: .gameResumed)
        case .secondHalf:
            playSound(for: .timerEnded)
            isFinished = true
        }

        if timeRemaining > 0 {
            runTimer()
        }
    }

    func resetTimer() {
        timer?.cancel()
        isTimerRunning = false
        isBreak = false
        isFirstHalf = true
        timeRemaining = gameDurationHalf
    }

    private func playSound(for event: TimerEvent) {
        print("Play sound for \(event.rawValue)")
        // Add sound playback logic here using AVFoundation
    }
}

enum GamePart {
    case firstHalf
    case `break`
    case secondHalf
    case withoutBreak
}

enum TimerEvent: String {
    case gameStarted, breakStarted, gameResumed, timerEnded
}

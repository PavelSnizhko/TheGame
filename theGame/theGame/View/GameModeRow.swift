//
//  GameModeRow.swift
//  theGame
//
//  Created by Pavlo Snizhko on 21.11.2024.
//

import SwiftUI

struct GameModeRow: View {
    var leadingImage: String
    var title: String
    var subtitle: String

    @Binding var totalSeconds: Double

    @State private var minutes: Double = 0
    @State private var seconds: Double = 0

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: leadingImage)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                Text(subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }

            Spacer()

            HStack(spacing: 8) {
                // Minutes Input
                VStack {
                    TextField("0", value: $minutes, formatter: formatter)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(6)
                    Text("min")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 60)

                // Seconds Input
                VStack {
                    TextField("0", value: $seconds, formatter: formatter)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .padding(6)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(6)
                    Text("sec")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 60)
            }
            .onChange(of: minutes) { updateTotalSeconds() }
            .onChange(of: seconds) { updateTotalSeconds() }
        }
        .padding()
    }

    private func updateTotalSeconds() {
        // Ensure seconds are capped at 59
        if seconds >= 60 {
            minutes += floor(seconds / 60)
            seconds = seconds.truncatingRemainder(dividingBy: 60)
        }

        totalSeconds = (minutes * 60) + seconds
    }
}

#Preview {
    GameModeRow(
        leadingImage: "clock",
        title: "Game Duration",
        subtitle: "Enter minutes to play",
        totalSeconds: .constant(10)
    )
}

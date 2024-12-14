//
//  CircularTimerView.swift
//  theGame
//
//  Created by Pavlo Snizhko on 23.11.2024.
//

import SwiftUI

struct CircularTimerView: View {
    var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: progress)
        }
    }
}

struct CircularTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CircularTimerView(progress: 0.5)
            .padding()
    }
}

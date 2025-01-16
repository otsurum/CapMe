//
//  LapTimeView.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/16.
//

import SwiftUI

struct LapTimeView: View {
    let lapTimes: [String]
    
    var body: some View {
        List(Array(lapTimes.enumerated().reversed()), id: \.offset) { index, lapTime in
            HStack {
                Text("ラップ\(index+1)")
                Spacer()
                Text(lapTime)
            }
        }
    }
}

#Preview {
    LapTimeView(lapTimes: [])
}

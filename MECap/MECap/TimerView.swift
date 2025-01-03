//
//  ContentView.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/03.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager = TimerManager()
    
    var body: some View {
        VStack {
            Text(String(format: "%0.1f" ,timerManager.seconds))
                .font(.custom("", size: 50))
            
            Button(action: {
                timerManager.start()
            }, label: {
                Text("スタート")
                    .foregroundStyle(.red)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    .background(.yellow)
                    .cornerRadius(10)
            })
        }
        .padding()
    }
}

#Preview {
    TimerView()
}

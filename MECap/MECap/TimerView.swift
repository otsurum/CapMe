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
                ExtractedView(label: "スタート", buttonColor: .yellow, textColor: .black)
            })
        }
        .padding()
    }
}

#Preview {
    TimerView()
}

struct ExtractedView: View {
    var label: String
    var buttonColor: Color
    var textColor: Color
    
    var body: some View {
        Text(label)
            .foregroundStyle(textColor)
            .padding(.vertical, 20)
            .padding(.horizontal, 40)
            .background(buttonColor)
            .cornerRadius(10)
    }
}

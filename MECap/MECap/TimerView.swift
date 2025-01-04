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
            
            
            if timerManager.mode == .stop {
                Button(action: {
                    timerManager.start()
                }, label: {
                    ExtractedView(label: "Start", buttonColor: .yellow, textColor: .black)
                })
            } else if timerManager.mode == .start {
                Button(action: {
                    timerManager.pause()
                }, label: {
                    ExtractedView(label: "Pause", buttonColor: .yellow, textColor: .blue)
                })
            } else if timerManager.mode == .pause {
                Button(action: {
                    timerManager.start()
                }, label: {
                    ExtractedView(label: "Start", buttonColor: .yellow, textColor: .black)
                })
                
                Button(action: {
                    timerManager.stopAndReset()
                }, label: {
                    ExtractedView(label: "Finish", buttonColor: .red, textColor: .black)
                })
            }
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
            .padding(.horizontal, 90)
            .background(buttonColor)
            .cornerRadius(10)
    }
}

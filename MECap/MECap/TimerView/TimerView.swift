//
//  ContentView.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/03.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager = TimerManager()
    @EnvironmentObject var eventManager: EventManager
    
    @State var startTime: Date?
    
    
    var body: some View {
        VStack {
            Text(timerManager.seconds.formattedTime())
                .font(.custom("", size: 50))
            
            
            if timerManager.mode == .stop {
                Button(action: {
                    startTime = Date()
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
                
                Button(action: {
                    timerManager.spreadRap()
                }, label: {
                    ExtractedView(label: "Split", buttonColor: .blue, textColor: .yellow)
                })
                
            } else if timerManager.mode == .pause {
                Button(action: {
                    timerManager.start()
                }, label: {
                    ExtractedView(label: "Start", buttonColor: .yellow, textColor: .black)
                })
                
                Button(action: {
                    if let startTime = startTime {
                        eventManager.createEvent(title: "タスク", startDate: startTime, endDate: Date(), lapTimes: timerManager.leadLapTime())
                    }
                    timerManager.stopAndReset()
                }, label: {
                    ExtractedView(label: "Finish", buttonColor: .red, textColor: .black)
                })
            }
            
            NavigationStack {
                List {
                    LapTimeView(lapTimes: timerManager.leadLapTime())
                }
            }.navigationTitle("ラップタイム")
        }
        .padding()
    }
}

#Preview {
    TimerView()
        .environmentObject(EventManager())
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

//
//  TimerManager.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/03.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var seconds = 0.0
    @Published var mode: timerMode = .stop
    var timer: Timer?
    
    enum timerMode {
        case start
        case stop
        case pause
    }
    
    func start() {
        if timer != nil {} else {
            // timerがnilの場合
            mode = .start
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.seconds += 0.1
            }
        }
    }
    
    func stopAndReset() {
        if timer != nil {
            timer?.invalidate()
            seconds = 0
            mode = .stop
        }
    }
    
    func pause() {
        if timer != nil {
            timer?.invalidate()
            mode = .pause
        }
    }
}

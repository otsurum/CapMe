//
//  TimerManager.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/03.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var seconds = 0.0
    var timer: Timer?
    
    func start() {
        if timer != nil {} else {
            // timerがnilの場合
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.seconds += 0.1
            }
        }
    }
}

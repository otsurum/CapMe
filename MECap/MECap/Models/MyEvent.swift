//
//  CustomEKEvent.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/16.
//

import Foundation
import EventKit

class MyEvent {
    @Published var lapTimesMemo = [String]()
    
    func noteLapTimes(lapTimes: [String]) {
        lapTimesMemo = lapTimes
    }
}

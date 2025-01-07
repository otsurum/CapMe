//
//  Double.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/07.
//

extension Double {
    func formattedTime() -> String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

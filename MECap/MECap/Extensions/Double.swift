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
        let seconds = self.truncatingRemainder(dividingBy: 60)
        let underFloat = seconds.truncatingRemainder(dividingBy: 1)*10
        
        if hours == 0 {
            return String(format: "%02d:%02d.%1d", minutes, Int(seconds), Int(underFloat))
        } else {
            return String(format: "%02d:%02d:%02d.%1d", hours, minutes, Int(seconds), Int(underFloat))
        }
    }
}

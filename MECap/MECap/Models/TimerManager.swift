//
//  TimerManager.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/03.
//

import Foundation
import UIKit

class TimerManager: ObservableObject {
    @Published var seconds: Double = 0.0
    @Published var mode: timerMode = .stop
    var timer: Timer?
    @Published var lapTimes = [Double]()
    
    private let timeInterval = 0.05
    
    private var backgroundDate: Date?
    
    enum timerMode {
        case start
        case stop
        case pause
    }
    
    init() {
        setUpBackgroundNotification()
    }
    
    func start() {
        mode = .start

        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.seconds += self.timeInterval
        }
    }
    
    func stopAndReset() {
        if timer != nil {
            timer?.invalidate()
            timer = nil // 終了したタイマーを消去
            seconds = 0
            mode = .stop // TimerModeをstopに変更
            lapTimes.removeAll() // ラップタイムの記録を消去
        }
    }
    
    func pause() {
        if timer != nil {
            timer?.invalidate()
            mode = .pause
        }
    }
    
    // 新しいタイマーを起動して一つ前のタイマーとの差をとる
    func spreadRap() {
        // timerプロパティに値があるかつ、TimerModeがstartかどうかをチェック
        if timer != nil && mode == .start {
            lapTimes.append(seconds)
        }
    }
    
    func leadLapTime() -> [String] {
        let countsOfLapTimes = lapTimes.count
        
        if countsOfLapTimes < 1 {
            return []
        } else if countsOfLapTimes == 1 {
            return lapTimes.map { $0.formattedTime() }
        }
        
        var returnedCollection = [String]()
        if let firstLapTime = lapTimes.first {
            returnedCollection.append(firstLapTime.formattedTime())
        }
        
        let copiedLapTimes = lapTimes
        let differentTimes = zip(copiedLapTimes, copiedLapTimes.dropFirst()).map { $1 - $0 }
        
        returnedCollection += differentTimes.map { $0.formattedTime() }
        
        return returnedCollection
    }
    
    func setUpBackgroundNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func didEnterBackground() {
        guard mode == .start else { return }
        backgroundDate = Date()
        pause()
    }
    
    @objc private func willEnterForeground() {
        guard mode == .pause, let backgroundDate = backgroundDate else { return }
        let elapsed = Date().timeIntervalSince(backgroundDate)
        seconds += elapsed
        start()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

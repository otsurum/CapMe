//
//  EventManager.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/12.
//

import Foundation
import EventKit

@MainActor
class EventManager: ObservableObject {
    @Published var store = EKEventStore()
    // イベントへの認証ステータスのメッセージ
    @Published var statusMessage = ""
    
    @Published var events: [EKEvent]? = nil
    
    @Published var day = Date()
    
    init() {
        Task {
            do {
                // カレンダーへのアクセスを要求,iOS16以前のため
                try await store.requestAccess(to: .event)
            } catch {
                print(error.localizedDescription)
            }
            // イベントへの認証ステータス
            let status = EKEventStore.authorizationStatus(for: .event)
            
            switch status {
            case .notDetermined:
                statusMessage = "カレンダーへのアクセスする\n権限が選択されていません。"
            case .restricted:
                statusMessage = "カレンダーへのアクセスする\n権限がありません。"
            case .denied:
                statusMessage = "カレンダーへのアクセスが\n明示的に拒否されています。"
            case .authorized:
                statusMessage = "カレンダーへのアクセスが\n許可されています。"
                fetchEvent()
                NotificationCenter.default.addObserver(self, selector: #selector(fetchEvent), name: .EKEventStoreChanged, object: store)
            case .fullAccess:
                statusMessage = "カレンダーへフルアクセスが\n許可されています"
            case .writeOnly:
                statusMessage = "カレンダーへの書き込みのみが\n許可されています"
            @unknown default:
                statusMessage = "@unknown default"
            }
        }
    }
    
    /// イベントの取得
    @objc func fetchEvent() {
        // 開始日コンポーネントの作成
        // 指定した日付の0:00:0
        let start = Calendar.current.startOfDay(for: day)
        // 終了日コンポーネントの作成
        // 指定した日付の23:59:1
        let end = Calendar.current.date(bySettingHour: 23, minute: 59, second: 1, of: start)
        // イベントストアのインスタンスメソッドから述語を作成
        var predicate: NSPredicate? = nil
        if let end {
            predicate = store.predicateForEvents(withStart: start, end: end, calendars: nil)
        }
        // 述語に一致するすべてのイベントを取得
        if let predicate {
            events = store.events(matching: predicate)
        }
    }
    
    /// イベントの追加
    func createEvent(title: String, startDate: Date, endDate: Date){
        // 新規イベントの作成
        let event = EKEvent(eventStore: store)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        // 保存するカレンダー
        // デフォルトカレンダー
        event.calendar = store.defaultCalendarForNewEvents
        do {
            try store.save(event, span: .thisEvent, commit: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// イベントの変更
    func modifyEvent(event: EKEvent,title: String, startDate: Date, endDate: Date){
        // 変更したいイベントを取得
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        // 保存するカレンダー
        // デフォルトカレンダー
        event.calendar = store.defaultCalendarForNewEvents
        do {
            try store.save(event, span: .thisEvent, commit: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteEvent(event: EKEvent){
        // 削除したいイベントを取得
        do {
            try store.remove(event, span: .thisEvent, commit: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

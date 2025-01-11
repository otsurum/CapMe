//
//  EventManager.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/12.
//

import Foundation
import EventKit

class EventManager: ObservableObject {
    var store = EKEventStore()
    // イベントへの認証ステータスのメッセージ
    @Published var statusMessage = ""

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
            case .fullAccess:
                statusMessage = "カレンダーへフルアクセスが\n許可されています"
            case .writeOnly:
                statusMessage = "カレンダーへの書き込みのみが\n許可されています"
            @unknown default:
                statusMessage = "@unknown default"
            }
        }
    }
}

//
//  MECapApp.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/03.
//

import SwiftUI

@main
struct MECapApp: App {
    var body: some Scene {
        WindowGroup {
            EntryView()
                .environmentObject(EventManager())
        }
    }
}

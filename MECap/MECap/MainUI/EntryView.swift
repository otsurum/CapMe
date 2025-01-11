//
//  EntryView.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/12.
//

import SwiftUI

struct EntryView: View {
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Image(systemName: "clock.fill")
                }
            EventView()
                .tabItem {
                    Image(systemName: "calendar")
                }
        }
    }
}

#Preview {
    EntryView()
        .environmentObject(EventManager())
}

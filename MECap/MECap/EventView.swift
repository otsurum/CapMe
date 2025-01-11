//
//  EventView.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/12.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var eventManager: EventManager
    
    var body: some View {
        Text(eventManager.statusMessage)
    }
}

#Preview {
    EventView()
        .environmentObject(EventManager())
}

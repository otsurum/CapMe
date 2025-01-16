//
//  EventView.swift
//  MECap
//
//  Created by 鶴見駿 on 2025/01/12.
//

import SwiftUI
import EventKit

struct EventView: View {
    @EnvironmentObject var eventManager: EventManager
        // sheetのフラグ
        @State var isShowCreateEventView = false
    
        @State var event: MyEKEvent?
        
        var body: some View {
            if let aEvent = eventManager.events {
                NavigationStack {
                    List(aEvent, id: \.eventIdentifier) { event in
                        Button(event.title) {
                            // 変更したいイベントをCreateEventViewに送る
                            self.event = event as? MyEKEvent
                            isShowCreateEventView = true
                        }
                        .contextMenu {
                            Button(role: .destructive) {
                                eventManager.deleteEvent(event: event)
                            } label: {
                                Label("削除", systemImage: "trash")
                            }
                        }
                    }
                    .sheet(isPresented: $isShowCreateEventView) {
                        CreateEventView(event: $event)
                            .presentationDetents([.medium])
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            DatePicker("", selection: $eventManager.day, displayedComponents: .date)
                                .labelsHidden()
                                .onChange(of: eventManager.day) { newValue in
                                    eventManager.fetchEvent()
                                }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                event = nil
                                isShowCreateEventView = true
                            } label: {
                                Label("追加", systemImage: "plus")
                            }
                        }
                    }
                }
            } else {
                Text(eventManager.statusMessage)
            }
        }
}

#Preview {
    EventView()
        .environmentObject(EventManager())
}

import SwiftUI
import EventKit

struct CreateEventView: View {
    @EnvironmentObject var eventManager: EventManager
    // ContentViewのsheetのフラグ
    @Environment(\.dismiss) var dismiss
    // eventのタイトル
    @State var title = ""
    // eventの開始日時
    @State var start = Date()
    // eventの終了日時
    @State var end = Date()
    
    @Binding var event: EKEvent?
    
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    TextField("タイトル", text: $title)
                    DatePicker("開始", selection: $start)
                }
                
                if let lapTimes = eventManager.decodeNotes(from: event?.notes) {
                    LapTimeView(lapTimes: lapTimes)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(event == nil ? "追加" : "変更") {
                        if let event {
                            eventManager.modifyEvent(event: event, title: title, startDate: start, endDate: end)
                        } else{
                            eventManager.createEvent(title: title, startDate: start, endDate: end)
                        }
                        // sheetを閉じる
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル", role: .destructive) {
                        // sheetを閉じる
                        dismiss()
                    }
                    .buttonStyle(.borderless)
                }
            }
        }
        .task {
            if let event {
                // eventが渡されたら既存の値をセットする(変更の場合)
                self.title = event.title
                self.start = event.startDate
                self.end = event.endDate
            }
        }
    }
}

//#Preview {
//    CreateEventView().environmentObject(EventManager())
//}

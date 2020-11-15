//
//  Countdown2Widget.swift
//  WidgetTest
//
//  Created by hanwe on 2020/11/15.
//

import WidgetKit
import SwiftUI
import Intents

private struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), displayDate: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), displayDate: Date())
        print("언제 호출될까")
        completion(entry)
    }
    

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let currentDate = Date()
        print("언제 호출되지:\(currentDate)")
//        let warningDate = Calendar.current.date(byAdding: .second, value: 5, to: currentDate)!
//        let displayDate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
//        let refreshDate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
        let refreshDate = Calendar.current.date(byAdding: .second, value: 30, to: currentDate)! //위젯 새로고침은 하루 최대한도가 있음. 시뮬레이터에서는 적용이 안되고 이게 구체적으로 몇회인지 알 수가 없음 ㅡㅡ;;;;;;;;
        // 테스트 결과 일단 최소 1분은 되어야 새로고침이 됨 흠......
        // https://developer.apple.com/forums/thread/653265?answerId=619739022#619739022 애플에서 1분은 너무 공격적, 15분 마다 하란다..
        
//        let entries = [
////            SimpleEntry(date: currentDate, displayDate: displayDate),
//            SimpleEntry(date: currentDate, displayDate: displayDate, isDateClose: true),
//
//        ]
//
////        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//        completion(timeline)
        
        var entries: [SimpleEntry] = []
//        for secondOffset in 0..<5 {
//            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate,displayDate: currentDate)
//            entries.append(entry)
//        }
        
        entries.append(SimpleEntry(date: currentDate, displayDate: currentDate))
        entries.append(SimpleEntry(date: refreshDate, displayDate: currentDate))
        
//        let entry = SimpleEntry(date: refreshDate, displayDate: refreshDate)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
//    func timeline(with context: Context, completion: @escaping (Timeline<PRListEntry>) -> ()) {
//        let currentDate = Date()
//        // 5분마다 refresh 하겠음
//        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
//
//        GithubFetcher.getPulls(owner: "eunjin3786", repo: "MyRepo") { result in
//            switch result {
//            case .success(let pulls):
//                let entry = Entry(date: currentDate, prList: pulls)
//                let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
//                completion(timeline)
//            case .failure:
//                let entries: [Entry] = []
//                let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//                completion(timeline)
//            }
//        }
//    }

}

private struct SimpleEntry: TimelineEntry {
    let date: Date
    let displayDate: Date
    var isDateClose = false
}

private struct Countdown2WidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.displayDate, style: .timer)
                .foregroundColor(entry.isDateClose ? .red : .primary)
                .multilineTextAlignment(.center)
            Image.init("tomato")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
        }
        
    }
}

struct Countdown2Widget: Widget {
    let kind: String = "Countdown2Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Countdown2WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Countdown2Widget")
        .description("Tis is My Countdown2Widget Widget")
        .supportedFamilies([.systemSmall])
    }
}


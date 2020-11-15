//
//  CountdownWidget.swift
//  WidgetTest
//
//  Created by hanwe on 2020/11/15.
//
//
//  DeepLinkWidget.swift
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
        print("언제 호출되지")
        let currentDate = Date()
        let firstDate = Calendar.current.date(byAdding: .second, value: 50, to: currentDate)!
        let secondDate = Calendar.current.date(byAdding: .second, value: 60, to: currentDate)!
        
        let entries = [ //총 두개의 엔트리를 만든다, 한개는 50초 후에 끝나고 한개는 60초 후에 끝남, 아마 두개 다 불리는게 끝나면 getTimeline이 호출되는 로직(.atEnd)
            SimpleEntry(date: currentDate, displayDate: secondDate),
//            SimpleEntry(date: secondDate, displayDate: secondDate),
            SimpleEntry(date: firstDate, displayDate: secondDate, isDateClose: true),
        ]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

private struct SimpleEntry: TimelineEntry {
    let date: Date
    let displayDate: Date
    var isDateClose = false
}

private struct CountdownWidgetEntryView : View {
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

struct CountdownWidget: Widget {
    let kind: String = "CountdownWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CountdownWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("CountdownWidget")
        .description("Tis is My CountdownWidget Widget")
        .supportedFamilies([.systemSmall])
    }
}

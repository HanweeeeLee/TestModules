//
//  MyWidgetType2.swift
//  WidgetTest
//
//  Created by hanwe on 2020/11/15.
//

import WidgetKit
import SwiftUI
import Intents

private struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

private struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

private struct MyWidgetType2EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct MyWidgetType2: Widget {
    let kind: String = "MyWidgetType2"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyWidgetType2EntryView(entry: entry)
        }
        .configurationDisplayName("My Widget type2")
        .description("Tis is My Type2 Widget")
        .supportedFamilies([.systemSmall,.systemMedium])
    }
}

//struct MyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        MyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}


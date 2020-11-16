//
//  EditableWidget.swift
//  WidgetTest
//
//  Created by hanwe lee on 2020/11/16.
//

import WidgetKit
import SwiftUI
import Intents

//public class MyData: INIntent {
//    @NSManaged public var param: String?
//}

private struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: EditableIntentIntent())
    }

    
    func getSnapshot(for configuration: EditableIntentIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: EditableIntentIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

private struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: EditableIntentIntent
}

private struct EditableWidgetEntryView : View {
    var entry: Provider.Entry

    @ViewBuilder
    var bgColor: some View {
        switch entry.configuration.bgColor {
        case .blue:
            Color.blue
        case .red:
            Color.red
        case .green:
            Color.green
        case .orange:
            Color.orange
        default:
            Color.primary.colorInvert()
        }
    }

    var body: some View {
        ZStack {
            bgColor
            Text(entry.date, style: .date)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
}

struct EditableWidget: Widget {
    let kind: String = "EditableWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: EditableIntentIntent.self, provider: Provider()) { entry in
            EditableWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("EditableWidget")
        .description("This is My EditableWidget Widget")
        .supportedFamilies([.systemSmall])
    }
}

//struct MyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        MyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}


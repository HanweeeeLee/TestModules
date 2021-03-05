//
//  WidgetExtensionSampleWidget.swift
//  WidgetExtensionSampleWidget
//
//  Created by hanwe lee on 2021/03/05.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        print("[life cycle] placeholder")
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        // 위젯을 추가하는등의 경우에 스냅샷을 요구 할 수 있다.
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        
        if context.isPreview {
            print("이것은 미리보기입니다.")
        }
        else {
            print("이것은 미리보기가 아닌 진짜 위젯입니다.")
        }
        
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        print("[life cycle] getTimeline")
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

struct SimpleEntry: TimelineEntry {
    let date: Date // required
    let configuration: ConfigurationIntent
    let fromAppData: String = ""
}

struct WidgetExtensionSampleWidgetEntryView : View {
    //이런식으로 분기 처리 할 수 있음
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry

    var body: some View {
//        Text(entry.date, style: .time)
        // 분기
        switch widgetFamily {
        case .systemLarge:
            Text("systemLarge")
            Link(destination: URL(string: "widget://test")!, label: {
                Text("링크 ! 이게 됨?")
            })
        case .systemMedium:
            Text("systemMedium")
        case .systemSmall:
            Text("systemSmall")
        @unknown default:
            Text("unkown")
        }
    }
    
    var largeView: some View {
        Text("this is large hello world")
    }
    
    var mediumView: some View {
        Text("this is medium hello world")
    }
}

@main
struct WidgetExtensionSampleWidget: Widget {
    let kind: String = "WidgetExtensionSampleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetExtensionSampleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

struct WidgetExtensionSampleWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetExtensionSampleWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        
        WidgetExtensionSampleWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

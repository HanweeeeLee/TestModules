//
//  DeepLinkWidget.swift
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

private struct DeepLinkWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: Provider.Entry
    
    var deeplinkURL: URL {
        URL(string: "widget-DeepLinkWidget1://widgetFamily/\(widgetFamily)")!
    }
    
    var deeplinkURL2: URL {
        URL(string: "widget-DeepLinkWidget2://widgetFamily/\(widgetFamily)")!
    }

    var body: some View {
        VStack {
//            Text("탭")
//                .widgetURL(deeplinkURL)
//            Text("탭2")
//                .widgetURL(deeplinkURL2)
            VStack(alignment: .leading) {
//                ForEach(0..<min(maxCount, entry.prList.count), id: \.self) { index in
//                    let pr = entry.prList[index]
//                    let url = URL(string: "widget://pr?url=\(pr.url)")!
//                    Link(destination: url) {
//                        PRView(pr: pr)
//                        Divider()
//                    }
//                }
                ForEach(0..<2) {index in
                    let myUrl = URL(string: "test\(index)")!
                    Link(destination: myUrl) {
                        if index == 0 {
                            View1()
                        }
                        else {
                            View2()
                        }
                        Divider()
                    }
                }
            }
//            .padding(.all, 16)
        }
    }
    
    struct View1: View {
        
        var deeplinkURL: URL {
            URL(string: "widget-DeepLinkWidget://widgetFamily/\("1")")!
        }
        var body: some View {
            VStack {
                Link(destination: deeplinkURL, label: { //이거 중/대형만 적용되는듯
                    Text("탭1")
                })
//                            Text("탭")
//                                .widgetURL(deeplinkURL)
            }
            .foregroundColor(.blue)
        }
    }
    struct View2: View {
        
        var deeplinkURL: URL {
            URL(string: "widget-DeepLinkWidget://widgetFamily/\("2")")!
        }
        
        var body: some View {
            VStack {
                Link(destination: deeplinkURL, label: {
                    Text("탭2!")
                })
//                            Text("탭2")
//                                .widgetURL(deeplinkURL2)
            }
        }
    }
}

struct DeepLinkWidget: Widget {
    let kind: String = "DeepLinkWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DeepLinkWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("DeepLinkWidget")
        .description("Tis is My DeepLinkWidget Widget")
        .supportedFamilies([.systemSmall,.systemMedium])
    }
}

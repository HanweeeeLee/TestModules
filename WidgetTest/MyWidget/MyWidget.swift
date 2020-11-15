//
//  MyWidget.swift
//  MyWidget
//
//  Created by hanwe on 2020/11/15.
//

import WidgetKit
import SwiftUI

@main
struct MyWidget: WidgetBundle {
    var body: some Widget {
        WidgetBundle1().body
    }
}

struct WidgetBundle1: WidgetBundle {
    var body: some Widget {
        MyWidgetType1()
        MyWidgetType2()
        DeepLinkWidget()
        CountdownWidget()
        Countdown2Widget()
    }
}

//struct MyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        MyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}


////
////  MyWidget.swift
////  MyWidget
////
////  Created by hanwe lee on 2020/11/05.
////
//
//import WidgetKit
//import SwiftUI
//import Intents
//
////struct Provider: IntentTimelineProvider { // IntentTimelineProvider 는 Intent Config에서만 쓰는듯
////    func placeholder(in context: Context) -> SimpleEntry {
////        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
////    }
////
////    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
////        let entry = SimpleEntry(date: Date(), configuration: configuration)
////        completion(entry)
////    }
////
////    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
////        var entries: [SimpleEntry] = []
////
////        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
////        let currentDate = Date()
////        for hourOffset in 0 ..< 5 {
////            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
////            let entry = SimpleEntry(date: entryDate, configuration: configuration)
////            entries.append(entry)
////        }
////
////        let timeline = Timeline(entries: entries, policy: .atEnd)
////        completion(timeline)
////
////    }
////}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent // static 만들고있는데 intentConfig가 들어가는 이유는?
//}
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
//        completion(SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
////        let timeline = Timeline(entries: [SimpleEntry(date: Date(), configuration: ConfigurationIntent())], policy: .never)
////        completion(timeline)
//
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: ConfigurationIntent())
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        //policy - .atEnd, .never, .after(date:)
//        //atEnd : 타임라인의 마지막 날짜가 지난 후 WidgetKit에서 새 타임라인을 요청
//        //after(date:) : WidgetKit이 새 타임라인을 요청할 미래 날짜를 지정하는 policy
//        //never : 앱이 WidgetCenter를 사용하여 WidgetKit에 새 타임라인을 요청하도록 지시 할 때 까지 다른 timeline을 요청하지 않음
//        completion(timeline)
//    }
//}
//
//struct MyWidgetEntryView : View {
//    @Environment(\.widgetFamily) private var widgetFamily //이런식으로 분기 처리 할 수 있음
//
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//        switch widgetFamily {// 분기
//        case .systemLarge:
//            Text("systemLarge")
//        case .systemMedium:
//            Text("systemMedium")
//        case .systemSmall:
//            Text("systemSmall")
//        @unknown default:
//            Text("unkown")
//        }
//    }
//}
//
////위젯의 Configuration은 2가지가 있음
//// 1. Static
//// 2. Intent
////이 프로젝트에서는 Static으로 만들어보겠음
//
//@main
//struct MyWidget: Widget {
//    let kind: String = Bundle.main.bundleIdentifier ?? "com.hanwe.SwiftUIWidgetTest.MyWidget" // 이 문자열을 통해 위젯을 식별함. 애플의 예제에선 bundle id를 씀...
//
//
//    public var body: some WidgetConfiguration {
//        // kind, provider, content ?
//        // kind : 위젯 식별자
//        // provider : 위젯을 새로고침할 타임라인을 결정하는 객체, 위젯 업데이트를 위한 미래날짜를 주면 시스템이 새로고침 프로세스를 최적화 할 수 있다고 함
//        // content : SwiftUI View
//        StaticConfiguration(kind: kind, provider: Provider(), content: { (entry) in
//            SimpleTodoWidgetEntryView(entry: entry)
//        })
//        .configurationDisplayName("My Widget") //사용자가 위젯을 추가/편집 할 때 위젯에 표시되는 이름을 설정하는 메소드
//        .description("This is an example widget.") // 사용자가 위젯을 추가/편집할 때 위젯에 표시되는 설명을 설정하는 메소드
//        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall]) // 위젯의 크기 지원 지정할 수 있음
//
//
//    }
//
//    struct SimpleTodoWidgetEntryView: View {
//        @Environment(\.widgetFamily) private var widgetFamily //이런식으로 분기 처리 할 수 있음
//
//        var entry: Provider.Entry
//
//        var body: some View {
//            Text(entry.date, style: .time)
//            switch widgetFamily {// 분기
//            case .systemLarge:
//                Text("systemLarge")
//            case .systemMedium:
//                Text("systemMedium")
//            case .systemSmall:
//                Text("systemSmall")
//            @unknown default:
//                Text("unkown")
//            }
//        }
//    }
//}
//
//struct MyWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        MyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

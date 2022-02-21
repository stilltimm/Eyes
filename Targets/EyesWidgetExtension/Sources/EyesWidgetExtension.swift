import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct EyesWidgetExtensionEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct EyesWidgetExtension: Widget {
    let kind: String = "EyesWidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            EyesWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("Eye")
        .description("This is one eye. Add two of them to your homescreen.")
        .supportedFamilies([.systemSmall])
    }
}

struct EyesWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        EyesWidgetExtensionEntryView(
            entry: SimpleEntry(
                date: Date()
            )
        )
        .previewContext(
            WidgetPreviewContext(family: .systemSmall)
        )
    }
}

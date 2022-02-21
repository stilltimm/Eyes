import WidgetKit
import SwiftUI

@main
struct SquareWidget: Widget {

    let kind: String = "EyeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: EyeWidgetTimelineProvider()
        ) { entry in
            EyeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Eye")
        .description("This is one eye. Add two of them to your homescreen.")
        .supportedFamilies([.systemSmall])
    }
}

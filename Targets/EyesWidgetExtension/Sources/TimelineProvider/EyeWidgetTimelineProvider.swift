//
//  EyeWidgetTimelineProvider.swift
//  EyeWidgetExtension
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import WidgetKit
import SwiftUI
import EyesKit

class EyeWidgetTimelineProvider: TimelineProvider {

    // MARK: - Nested Types

    typealias Entry = EyeWidgetTimelineEntry

    // MARK: - Private Instance Properties

    private var lastGeneratedEntry: Entry?
    private let transformInfoFactory: TransformInfoFactory = .default()

    // MARK: - Public Instance Methods

    func placeholder(in context: Context) -> Entry {
        return Entry.placeholder()
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        completion(Entry.placeholder())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let currentDate = Date()
        let entry = Entry(date: currentDate, transformInfo: .identity)

        var entries: [Entry] = [entry]

        let timelineReloadPolicy: TimelineReloadPolicy
        for i in 1...(Constants.updatesCount - 1) {
            guard let entryDate = Calendar.autoupdatingCurrent.date(
                byAdding: .second,
                value: i * Constants.updatesInterval,
                to: currentDate
            ) else { continue }

            let entry = Entry(
                date: entryDate,
                transformInfo: transformInfoFactory.makeRandomTransformInfo()
            )
            entries.append(entry)
        }

        if
            let timelineEndDate = Calendar.autoupdatingCurrent.date(
                byAdding: .second,
                value: (Constants.updatesCount) * Constants.updatesInterval,
                to: currentDate
            )
        {
            timelineReloadPolicy = .after(timelineEndDate)
        } else {
            timelineReloadPolicy = .atEnd
        }

        let timeline = Timeline(entries: entries, policy: timelineReloadPolicy)
        completion(timeline)
    }
}

private enum Constants {

    static let updatesInterval: Int = 30
    static let updatesCount: Int = 120
}

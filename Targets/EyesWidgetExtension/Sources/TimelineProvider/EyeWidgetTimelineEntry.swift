//
//  EyeWidgetTimelineEntry.swift
//  EyeWidgetExtension
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import WidgetKit
import EyesKit

struct EyeWidgetTimelineEntry: TimelineEntry {

    let date: Date
    let transformInfo: TransformInfo
}

extension EyeWidgetTimelineEntry {

    static func placeholder() -> EyeWidgetTimelineEntry {
        return EyeWidgetTimelineEntry(
            date: Date(),
            transformInfo: .identity
        )
    }
}

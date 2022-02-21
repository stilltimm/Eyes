//
//  EyeWidgetEntryView.swift
//  EyeWidgetExtension
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import SwiftUI
import WidgetKit
import EyesKit

struct EyeWidgetEntryView: View {

    let entry: EyeWidgetTimelineEntry

    var body: some View {

        return GeometryReader { metrics in
            let xOffset = entry.transformInfo.x * metrics.size.width * 0.4
            let yOffset = entry.transformInfo.y * metrics.size.height * 0.4

            ZStack(alignment: .center) {
                Rectangle()
                    .frame(
                        width: metrics.size.width,
                        height: metrics.size.height,
                        alignment: .center
                    )
                    .foregroundColor(.white)
                Group {
                    Rectangle()
                        .foregroundColor(.black)
                        .rotationEffect(
                            Angle(degrees: Double(entry.transformInfo.rotationAngle) * 90),
                            anchor: .center
                        )
                        .scaleEffect(entry.transformInfo.scale)
                }
                .frame(
                    width: min(metrics.size.width, metrics.size.height) * GoldenRatio.inversedCGFloatValue,
                    height: min(metrics.size.width, metrics.size.height) * GoldenRatio.inversedCGFloatValue,
                    alignment: .center
                )
                .position(
                    x: metrics.size.width / 2 + xOffset,
                    y: metrics.size.height / 2 + yOffset
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct EyeWidgetEntryViewPreview: PreviewProvider {

    static var previews: some View {
        EyeWidgetEntryView(
            entry: EyeWidgetTimelineEntry(
                date: Date(),
                transformInfo: TransformInfo(
                    x: 0.3,
                    y: 0.7,
                    rotationAngle: 0.2,
                    scale: 1.5
                )
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

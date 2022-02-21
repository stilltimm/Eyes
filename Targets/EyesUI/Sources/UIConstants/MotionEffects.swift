//
//  MotionEffect.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

public enum MotionEffects {

    public static let amplitude: Float = 12

    public static func verticalTiltTransformY(inverted: Bool = false) -> InterpolatingEffectContext {
        return .verticalTilt(
            keyPath: .transformY,
            minValue: inverted ? amplitude : -amplitude,
            maxValue: inverted ? -amplitude : amplitude
        )
    }

    public static func horizontalTiltTransformX(inverted: Bool = false) -> InterpolatingEffectContext {
        return .horizontalTilt(
            keyPath: .transformX,
            minValue: inverted ? amplitude : -amplitude,
            maxValue: inverted ? -amplitude : amplitude
        )
    }
}

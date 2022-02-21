//
//  InterpolatingEffectContext.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

public struct InterpolatingEffectContext: Hashable {

    // MARK: - Instance Properties

    public let type: UIInterpolatingMotionEffect.EffectType
    public let keyPath: InterpolatingMotionEffectKeyPath
    public let minValue: NSNumber
    public let maxValue: NSNumber

    // MARK: - Initializers

    public init(
        type: UIInterpolatingMotionEffect.EffectType,
        keyPath: InterpolatingMotionEffectKeyPath,
        minValue: NSNumber,
        maxValue: NSNumber
    ) {
        self.type = type
        self.keyPath = keyPath
        self.minValue = minValue
        self.maxValue = maxValue
    }

    public init(
        type: UIInterpolatingMotionEffect.EffectType,
        keyPath: InterpolatingMotionEffectKeyPath,
        minValue: Float,
        maxValue: Float
    ) {
        self.type = type
        self.keyPath = keyPath
        self.minValue = NSNumber(value: minValue)
        self.maxValue = NSNumber(value: maxValue)
    }
}

extension InterpolatingEffectContext {

    public static func verticalTilt(
        keyPath: InterpolatingMotionEffectKeyPath,
        minValue: Float,
        maxValue: Float
    ) -> InterpolatingEffectContext {
        return InterpolatingEffectContext(
            type: .tiltAlongVerticalAxis,
            keyPath: keyPath,
            minValue: minValue,
            maxValue: maxValue
        )
    }

    public static func horizontalTilt(
        keyPath: InterpolatingMotionEffectKeyPath,
        minValue: Float,
        maxValue: Float
    ) -> InterpolatingEffectContext {
        return InterpolatingEffectContext(
            type: .tiltAlongHorizontalAxis,
            keyPath: keyPath,
            minValue: minValue,
            maxValue: maxValue
        )
    }
}

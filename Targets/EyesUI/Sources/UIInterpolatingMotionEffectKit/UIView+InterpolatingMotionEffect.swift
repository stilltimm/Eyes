//
//  UIView+InterpolatingMotionEffect.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

extension UIView {

    // MARK: - Public Type Methods

    public static func addInterpolatingMotionEffects(
        interpolatingEffectContexts: [InterpolatingEffectContext],
        to views: [UIView]
    ) {
        guard !interpolatingEffectContexts.isEmpty, !views.isEmpty else { return }
        views.forEach { view in
            view.addInterpolatingMotionEffects(interpolatingEffectContexts: interpolatingEffectContexts)
        }
    }

    public static func addInterpolatingMotionEffects(
        _ interpolatingEffectContexts: InterpolatingEffectContext...,
        to views: [UIView]
    ) {
        addInterpolatingMotionEffects(interpolatingEffectContexts: interpolatingEffectContexts, to: views)
    }

    // MARK: - Public Instance Methods

    public func addInterpolatingMotionEffects(
        interpolatingEffectContexts: [InterpolatingEffectContext]
    ) {
        guard !interpolatingEffectContexts.isEmpty else { return }

        let motionEffects: [UIMotionEffect] = interpolatingEffectContexts
            .map { context -> UIInterpolatingMotionEffect in
                let motionEffect =  UIInterpolatingMotionEffect(
                    keyPath: context.keyPath.value,
                    type: context.type
                )
                motionEffect.minimumRelativeValue = context.minValue
                motionEffect.maximumRelativeValue = context.maxValue
                return motionEffect
            }

        let motionEffectsGroup = UIMotionEffectGroup()
        motionEffectsGroup.motionEffects = motionEffects
        self.addMotionEffect(motionEffectsGroup)
    }

    public func addInterpolatingMotionEffects(
        _ interpolatingEffectContexts: InterpolatingEffectContext...
    ) {
        self.addInterpolatingMotionEffects(interpolatingEffectContexts: interpolatingEffectContexts)
    }

    public func removeAllMotionEffects() {
        self.motionEffects.forEach { self.removeMotionEffect($0) }
    }
}

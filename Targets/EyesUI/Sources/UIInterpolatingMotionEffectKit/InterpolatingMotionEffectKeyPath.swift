//
//  UIView+InterpolatingMotionEffectKeyPath.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import Foundation

public struct InterpolatingMotionEffectKeyPath: Hashable {

    // MARK: - Instance Properties

    public let value: String

    // MARK: - Initializers

    public init(_ value: String) {
        self.value = value
    }
}

extension InterpolatingMotionEffectKeyPath: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.value = value
    }
}

extension InterpolatingMotionEffectKeyPath {

    public static let transformX: InterpolatingMotionEffectKeyPath = "center.x"
    public static let transformY: InterpolatingMotionEffectKeyPath = "center.y"
}

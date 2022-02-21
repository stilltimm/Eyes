//
//  TransformInfo.swift
//  EyesKit
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

public struct TransformInfo {

    // MARK: - Instance Properties

    public let x: CGFloat
    public let y: CGFloat
    public let rotationAngle: CGFloat
    public let scale: CGFloat

    // MARK: - Initializers

    public init(
        x: CGFloat,
        y: CGFloat,
        rotationAngle: CGFloat,
        scale: CGFloat
    ) {
        self.x = x
        self.y = y
        self.rotationAngle = rotationAngle
        self.scale = scale
    }
}

extension TransformInfo {

    public static let identity: TransformInfo = TransformInfo(x: 0, y: 0, rotationAngle: 0, scale: 1)
}

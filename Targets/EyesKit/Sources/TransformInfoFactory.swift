//
//  TransformInfoFactory.swift
//  EyesKit
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

public final class TransformInfoFactory {

    // MARK: - Private Type Properties

    private static let calculationsQueue: DispatchQueue = DispatchQueue(
        label: "com.timofeysurkov.eyes.transformInfoFactory.calculationsQueue",
        qos: .userInitiated,
        attributes: [.concurrent],
        autoreleaseFrequency: .workItem,
        target: nil
    )

    // MARK: - Private Instance Properties

    private let minX: CGFloat
    private let xSpread: CGFloat

    private let minY: CGFloat
    private let ySpread: CGFloat

    private let minRotationAngle: CGFloat
    private let rotationAngleSpread: CGFloat

    private let minScale: CGFloat
    private let scaleSpread: CGFloat

    // MARK: - Initializers

    public init(
        minX: CGFloat,
        maxX: CGFloat,
        minY: CGFloat,
        maxY: CGFloat,
        minRotationAngle: CGFloat,
        maxRotationAngle: CGFloat,
        minScale: CGFloat,
        maxScale: CGFloat
    ) {
        self.minX = minX < maxX ? minX : maxX
        self.xSpread = abs(maxX - minX)

        self.minY = minY < maxY ? minY : maxY
        self.ySpread = abs(maxY - minY)

        self.minRotationAngle = minRotationAngle < maxRotationAngle ? minRotationAngle : maxRotationAngle
        self.rotationAngleSpread = abs(maxRotationAngle - minRotationAngle)

        self.minScale = minScale < maxScale ? minScale : maxScale
        self.scaleSpread = abs(maxScale - minScale)
    }

    // MARK: - Public Instance Properties

    public func makeRandomTransformInfo() -> TransformInfo {
        var result: TransformInfo!

        Self.calculationsQueue.sync {
            let x = minX + xSpread * self.makeRandomSeed()
            let y = minY + ySpread * self.makeRandomSeed()
            let rotationAngle = minRotationAngle + rotationAngleSpread * self.makeRandomSeed()
            let scale = minScale + scaleSpread * self.makeRandomSeed()

            result = TransformInfo(x: x, y: y, rotationAngle: rotationAngle, scale: scale)
        }

        return result
    }

    // MARK: - Private Instance Methods

    private func makeRandomSeed() -> CGFloat {
        return CGFloat(arc4random_uniform(Constants.randomSpreadUInt32)) / Constants.randomSpreadCGFloat
    }
}

extension TransformInfoFactory {

    public static func `default`() -> TransformInfoFactory {
        return TransformInfoFactory(
            minX: -1,
            maxX: 1,
            minY: -1,
            maxY: 1,
            minRotationAngle: -1,
            maxRotationAngle: 1,
            minScale: 0.5,
            maxScale: 1.5
        )
    }
}

private enum Constants {

    static let randomSpreadUInt32: UInt32 = 101
    static let randomSpreadCGFloat: CGFloat = 100.0
}

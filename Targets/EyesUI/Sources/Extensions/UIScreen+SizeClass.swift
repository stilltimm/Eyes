//
//  UIScreen+SizeClass.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

extension UIScreen {

    // MARK: - Nested Types

    enum SizeClass: UInt8 {

        case compact
        case medium
        case wide
    }

    // MARK: - Instance Properties

    var sizeClass: SizeClass {
        if self.bounds.width >= Constants.wideSizeClassThreshold {
            return .wide
        } else if self.bounds.width >= Constants.mediumSizeClassThreshold {
            return .medium
        } else {
            return .compact
        }
    }
}

public func sizeClassAdaptive<T>(
    compact: T,
    medium: T,
    wide: T? = nil
) -> T {
    switch UIScreen.main.sizeClass {
    case .compact:
        return compact

    case .medium:
        return medium

    case .wide:
        if let wide = wide {
            return wide
        }
        return medium
    }
}

private enum Constants {

    static let wideSizeClassThreshold: CGFloat = 390
    static let mediumSizeClassThreshold: CGFloat = 375
}

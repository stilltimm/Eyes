//
//  Colors.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

public enum Colors {

    // MARK: - Public Instance Properties

    public static let backgroundMainLight: UIColor = .white
    public static let foregroundMainLight: UIColor = .black

    public static let backgroundMain: UIColor = .dynamic(
        light: UIColor.white,
        dark: UIColor.black
    )
    public static let foregroundMain: UIColor = .dynamic(
        light: UIColor.black,
        dark: UIColor.white
    )
}

extension UIColor {

    // MARK: - Public Type Methods

    public static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { traitCollection -> UIColor in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return light

            case .dark:
                return dark

            case .unspecified:
                return light

            @unknown default:
                return light
            }
        }
    }
}

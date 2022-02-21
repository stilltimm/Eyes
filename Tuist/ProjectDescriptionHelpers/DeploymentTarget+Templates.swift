//
//  DeploymentTarget+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Timofey Surkov on 20.02.2022.
//

import ProjectDescription

extension DeploymentTarget {

    public static func iOS_14_iPhone() -> DeploymentTarget {
        return DeploymentTarget.iOS(targetVersion: "14.0", devices: .iphone)
    }
}

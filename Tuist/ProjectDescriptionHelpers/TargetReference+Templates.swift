//
//  TargetReference+Templates.swift
//  appManifests
//
//  Created by Timofey Surkov on 20.02.2022.
//

import ProjectDescription

extension TargetReference {

    public static func app() -> TargetReference {
        return TargetReference(projectPath: nil, target: ProjectConstants.appTargetName)
    }

    public static func ui() -> TargetReference {
        return TargetReference(projectPath: nil, target: ProjectConstants.uiTargetName)
    }

    public static func kit() -> TargetReference {
        return TargetReference(projectPath: nil, target: ProjectConstants.kitTargetName)
    }

    public static func widgetExtension() -> TargetReference {
        return TargetReference(projectPath: nil, target: ProjectConstants.widgetTargetName)
    }
}

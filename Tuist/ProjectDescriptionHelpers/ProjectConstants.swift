//
//  ProjectCosntants.swift
//  ProjectDescriptionHelpers
//
//  Created by Timofey Surkov on 20.02.2022.
//

import ProjectDescription

public enum ProjectConstants {

    // MARK: - Project

    public static let developmentTeam: String = "PL6N9LRHKL"
    public static let organizationName: String = "com.timofeysurkov"
    public static let projectName: String = "weyedget"
    public static let currentProjectVersion: String = "1"

    // MARK: - App Target

    public static let appTargetName: String = "Eyes"
    public static let appBundleIdentifier: String = "\(organizationName).eyes"
    public static let appDevelopmentProvisioningProfileName: String = "Eyes Dev"
    public static let appDistributionProvisioningProfileName: String = "Eyes AppStore"

    // MARK: - Kit Target

    public static let kitTargetName: String = "EyesKit"
    public static let kitBundleIdentifier: String = "\(organizationName).eyesKit"

    // MARK: - UI Target

    public static let uiTargetName: String = "EyesUI"
    public static let uiBundleIdentifier: String = "\(organizationName).eyesUI"

    // MARK: - Widget Target

    public static let widgetTargetName: String = "EyesWidgetExtension"
    public static let widgetBundleIdentifier: String = "\(organizationName).eyes.widgetExtension"
    public static let widgetDevelopmentProvisioningProfileName: String = "Eyes Widget Dev"
    public static let widgetDistributionProvisioningProfileName: String = "Eyes Widget AppStore"
}

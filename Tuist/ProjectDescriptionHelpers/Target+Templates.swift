//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Timofey Surkov on 20.02.2022.
//

import ProjectDescription

extension Target {

    // MARK: - Public Type Properties

    public static func appTarget() -> Target {
        return makeTarget(
            name: ProjectConstants.appTargetName,
            product: .app,
            bundleId: ProjectConstants.appBundleIdentifier,
            hasResources: true,
            hasHeaders: false,
            hasEntitlements: true,
            scripts: [.tuistLint()],
            dependencies: [
                .target(name: ProjectConstants.kitTargetName),
                .target(name: ProjectConstants.uiTargetName),
                .target(name: ProjectConstants.widgetTargetName),
            ],
            settings: .appSettings()
        )
    }

    public static func widgetExtensionTarget() -> Target {
        return makeTarget(
            name: ProjectConstants.widgetTargetName,
            product: .appExtension,
            bundleId: ProjectConstants.widgetBundleIdentifier,
            hasResources: false,
            hasHeaders: false,
            hasEntitlements: true,
            scripts: [.tuistLint()],
            dependencies: [
                .target(name: ProjectConstants.kitTargetName),
                .sdk(name: "SwiftUI.framework", status: .required),
                .sdk(name: "WidgetKit.framework", status: .required),
            ],
            settings: .widgetExtensionSettings()
        )
    }

    public static func kitTarget() -> Target {
        return makeTarget(
            name: ProjectConstants.kitTargetName,
            product: .framework,
            bundleId: ProjectConstants.kitBundleIdentifier,
            hasResources: false,
            hasHeaders: true,
            hasEntitlements: false,
            scripts: [.tuistLint(), .fixSPM()],
            dependencies: [],
            settings: .anyFrameworkSettings(onlyAllowAppExtensionAPI: true)
        )
    }

    public static func uiTarget() -> Target {
        return makeTarget(
            name: ProjectConstants.uiTargetName,
            product: .framework,
            bundleId: ProjectConstants.uiBundleIdentifier,
            hasResources: true,
            hasHeaders: true,
            hasEntitlements: false,
            scripts: [.tuistLint()],
            dependencies: [
                .target(name: ProjectConstants.kitTargetName)
            ],
            settings: .anyFrameworkSettings(onlyAllowAppExtensionAPI: false)
        )
    }

    // MARK: - Private Type Properties

    private static func makeTarget(
        name: String,
        product: Product,
        bundleId: String,
        hasResources: Bool,
        hasHeaders: Bool,
        hasEntitlements: Bool,
        scripts: [TargetScript],
        dependencies: [TargetDependency],
        settings: Settings
    ) -> Target {
        var resources: ResourceFileElements?
        if hasResources {
            resources = ["Targets/\(name)/Resources/**"]
        }

        var headers: Headers?
        if hasHeaders {
            headers = .headers(
                public: "Targets/\(name)/Headers/Public/**",
                private: "Targets/\(name)/Headers/Private/**",
                project: nil,
                exclusionRule: .publicExcludesPrivateAndProject
            )
        }

        var entitlementsPath: Path?
        if hasEntitlements {
            entitlementsPath = "Targets/\(name)/SupportFiles/\(name).entitlements"
        }

        return Target(
            name: name,
            platform: .iOS,
            product: product,
            bundleId: bundleId,
            deploymentTarget: .iOS_14_iPhone(),
            infoPlist: .file(path: "Targets/\(name)/SupportFiles/Info.plist"),
            sources: ["Targets/\(name)/Sources/**"],
            resources: resources,
            headers: headers,
            entitlements: entitlementsPath,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings
        )
    }
}

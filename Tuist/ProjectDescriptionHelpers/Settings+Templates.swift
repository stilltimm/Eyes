//
//  Settings+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Timofey Surkov on 20.02.2022.
//

import ProjectDescription

extension SettingsDictionary {

    func developmentTeam(_ developmentTeam: String) -> SettingsDictionary {
        var result = self
        result["DEVELOPMENT_TEAM"] = .string(developmentTeam)
        return result
    }

    func activeCompilationConditions(_ conditions: String...) -> SettingsDictionary {
        var result = self
        result["SWIFT_ACTIVE_COMPILATION_CONDITIONS"] = .array(conditions)
        return result
    }

    func gccPreprocessorDefinitions(_ conditions: String...) -> SettingsDictionary {
        var result = self
        result["GCC_PREPROCESSOR_DEFINITIONS"] = .array(conditions)
        return result
    }

    func currentLibraryVersion(_ version: String) -> SettingsDictionary {
        var result = self
        result["DYLIB_CURRENT_VERSION"] = .string(version)
        result["DYLIB_COMPATIBILITY_VERSION"] = .string(version)
        return result
    }

    func generateInfoPlistFile(_ generate: Bool) -> SettingsDictionary {
        var result = self
        result["GENERATE_INFOPLIST_FILE"] = generate ? .string("YES") : .string("NO")
        return result
    }
}

extension Settings {

    // MARK: - Private Type Methods

    private static func makeSettings(
        base baseSettings: SettingsDictionary = SettingsDictionary(),
        debug debugSettings: SettingsDictionary,
        beta betaSettings: SettingsDictionary,
        release releaseSettings: SettingsDictionary
    ) -> Settings {
        let debugConfiguration = Configuration.debug(name: .debug, settings: debugSettings)
        let betaConfiguration = Configuration.release(name: .beta, settings: betaSettings)
        let releaseConfiguration = Configuration.release(name: .release, settings: releaseSettings)
        return .settings(
            base: baseSettings,
            configurations: [
                debugConfiguration,
                betaConfiguration,
                releaseConfiguration
            ]
        )
    }

    // MARK: - Public Type Methods

    public static func projectSettings() -> Settings {
        let baseSettings = SettingsDictionary()
            .developmentTeam(ProjectConstants.developmentTeam)
            .swiftVersion("5.5")
            .appleGenericVersioningSystem()
            .currentProjectVersion(ProjectConstants.currentProjectVersion)
        let debugSettings = SettingsDictionary()
            .activeCompilationConditions("DEBUG")
            .gccPreprocessorDefinitions("DEBUG=1")
        let betaSettings = SettingsDictionary()
            .swiftOptimizationLevel(.o)
            .swiftCompilationMode(.wholemodule)
            .activeCompilationConditions("BETA")
            .gccPreprocessorDefinitions("BETA=1")
        let releaseSettings = SettingsDictionary()
            .swiftOptimizationLevel(.o)
            .swiftCompilationMode(.wholemodule)
            .activeCompilationConditions("RELEASE")
            .gccPreprocessorDefinitions("RELEASE=1")
        return .makeSettings(
            base: baseSettings,
            debug: debugSettings,
            beta: betaSettings,
            release: releaseSettings
        )
    }

    public static func appSettings() -> Settings {
        let debugSettings = SettingsDictionary()
            .manualCodeSigning(
                identity: "iPhone Developer",
                provisioningProfileSpecifier: ProjectConstants.appDevelopmentProvisioningProfileName
            )
        let betaAndReleaseSettings = SettingsDictionary()
            .manualCodeSigning(
                identity: "iPhone Distribution",
                provisioningProfileSpecifier: ProjectConstants.appDistributionProvisioningProfileName
            )
        return .makeSettings(
            debug: debugSettings,
            beta: betaAndReleaseSettings,
            release: betaAndReleaseSettings
        )
    }

    public static func widgetExtensionSettings() -> Settings {
        let baseSettings = SettingsDictionary()
            .generateInfoPlistFile(true)
        let debugSettings = SettingsDictionary()
            .manualCodeSigning(
                identity: "iPhone Developer",
                provisioningProfileSpecifier: ProjectConstants.widgetDevelopmentProvisioningProfileName
            )
        let betaAndReleaseSettings = SettingsDictionary()
            .manualCodeSigning(
                identity: "iPhone Distribution",
                provisioningProfileSpecifier: ProjectConstants.widgetDistributionProvisioningProfileName
            )
        return .makeSettings(
            base: baseSettings,
            debug: debugSettings,
            beta: betaAndReleaseSettings,
            release: betaAndReleaseSettings
        )
    }

    public static func anyFrameworkSettings() -> Settings {
        let baseSettings = SettingsDictionary()
            .currentProjectVersion(ProjectConstants.currentProjectVersion)
            .currentLibraryVersion(ProjectConstants.currentProjectVersion)
        let debugSettings = SettingsDictionary()
            .codeSignIdentityAppleDevelopment()
        let betaAndReleaseSettings = SettingsDictionary()
            .sign
        return .makeSettings(
            base: baseSettings,
            debug: debugSettings,
            beta: betaAndReleaseSettings,
            release: betaAndReleaseSettings
        )
    }
}

extension ConfigurationName {

    static let beta: ConfigurationName = "Beta"
}

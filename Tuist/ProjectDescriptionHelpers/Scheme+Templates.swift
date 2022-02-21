//
//  Scheme+Templates.swift
//  appManifests
//
//  Created by Timofey Surkov on 20.02.2022.
//

import ProjectDescription

extension Scheme {

    // MARK: - Public Type Methods

    public static func makeAppScheme() -> Scheme {
        return makeScheme(
            schemeName: ProjectConstants.appTargetName,
            buildActionTargetReferences: [.app()],
            executableTargetReference: .app()
        )
    }

    public static func makeKitDebugScheme() -> Scheme {
        return makeScheme(
            schemeName: ProjectConstants.kitTargetName,
            buildActionTargetReferences: [.kit()],
            executableTargetReference: nil
        )
    }

    public static func makeUIScheme() -> Scheme {
        return makeScheme(
            schemeName: ProjectConstants.uiTargetName,
            buildActionTargetReferences: [.ui()],
            executableTargetReference: nil
        )
    }

    public static func makeWidgetExtensionScheme() -> Scheme {
        return makeScheme(
            schemeName: ProjectConstants.widgetTargetName,
            buildActionTargetReferences: [.app(), .widgetExtension()],
            executableTargetReference: nil
        )
    }

    // MARK: - Internal Type Methods

    static func makeScheme(
        schemeName: String,
        buildActionTargetReferences: [TargetReference],
        executableTargetReference: TargetReference?
    ) -> Scheme {
        let arguments: Arguments = Arguments()

        var runAction: RunAction?
        var profileAction: ProfileAction?
        if let executableTargetReference = executableTargetReference {
            runAction = .runAction(
                configuration: .debug,
                executable: executableTargetReference,
                arguments: arguments,
                options: .options(
                    language: nil,
                    storeKitConfigurationPath: nil,
                    simulatedLocation: nil
                )
            )
            profileAction = .profileAction(
                configuration: .release,
                executable: executableTargetReference,
                arguments: arguments
            )
        }

        let analyzeAction: AnalyzeAction = .analyzeAction(configuration: .debug)
        let archiveAction: ArchiveAction = .archiveAction(
            configuration: .release,
            revealArchiveInOrganizer: true,
            customArchiveName: nil,
            preActions: [],
            postActions: []
        )

        return Scheme(
            name: schemeName,
            shared: true,
            hidden: false,
            buildAction: .buildAction(
                targets: buildActionTargetReferences,
                preActions: [],
                postActions: [],
                runPostActionsOnFailure: false
            ),
            testAction: nil,
            runAction: runAction,
            archiveAction: archiveAction,
            profileAction: profileAction,
            analyzeAction: analyzeAction
        )
    }
}

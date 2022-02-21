import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: ProjectConstants.projectName,
    organizationName: ProjectConstants.organizationName,
    options: [
        .textSettings(
            usesTabs: false,
            indentWidth: 4,
            tabWidth: 4,
            wrapsLines: false
        )
    ],
    settings: .projectSettings(),
    targets: [
        .appTarget(),
        .kitTarget(),
        .uiTarget(),
        .widgetExtensionTarget()
    ],
    schemes: [
        .makeAppScheme(),
        .makeKitDebugScheme(),
        .makeUIScheme(),
        .makeWidgetExtensionScheme()
    ],
    additionalFiles: [],
    resourceSynthesizers: [.assets(), .strings(), .fonts()]
)

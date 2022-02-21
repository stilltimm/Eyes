//
//  HomeViewController.swift
//  Eyes
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit
import EyesKit
import EyesUI

public final class HomeViewController: UIViewController {

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = EyesUIFontFamily.AkzidenzGroteskBQ.boldExtended.font(size: 48)
        label.textColor = Colors.foregroundMain
        label.text = "eyes"
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        let text = """
        give your
        lovely iPhone
        the sight
        it deserves
        """
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                .font: EyesUIFontFamily.AkzidenzGroteskBQ.lightExtended.font(size: 32),
                .foregroundColor: Colors.foregroundMain.withAlphaComponent(0.5),
                .paragraphStyle: paragraphStyle
            ]
        )
        label.attributedText = attributedText
        return label
    }()
    private let infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.foregroundMain
        let attributedTitle = NSAttributedString(
            string: "i",
            attributes: [
                .font: EyesUIFontFamily.AkzidenzGroteskBQ.boldExtended.font(size: 32),
                .foregroundColor: Colors.backgroundMain
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        return button
    }()
    private let deviceView = DeviceView()
    private let gradientOverlayView = LinearGradientView(gradient: .overlay)

    // MARK: - Private Instance Properties

    private let transformInfoFactory: TransformInfoFactory = .default()

    // MARK: - Instance Methods

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupMotionEffects()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = Colors.backgroundMain
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupBusinessLogic()
    }

    // MARK: - Private Instance Methods

    private func setupLayout() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundMain

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(infoButton)
        view.addSubview(deviceView)
        view.addSubview(gradientOverlayView)

        NSLayoutConstraint.activate([
            // info button
            infoButton.widthAnchor.constraint(equalToConstant: Constants.infoSize.width),
            infoButton.heightAnchor.constraint(equalToConstant: Constants.infoSize.height),
            infoButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.edgeInsets.top
            ),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.edgeInsets.right),
            // title
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.edgeInsets.left),
            titleLabel.centerYAnchor.constraint(equalTo: infoButton.centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: infoButton.leftAnchor, constant: -Constants.titleToInfoSpacing),
            // subtitle
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(
                equalTo: infoButton.bottomAnchor,
                constant: Constants.infoToSubtitleSpacing
            ),
            subtitleLabel.rightAnchor.constraint(equalTo: infoButton.rightAnchor),
            // device
            deviceView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.edgeInsets.left),
            deviceView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.edgeInsets.right),
            deviceView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            deviceView.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: Constants.subtitleToDeviceSpacing
            ),
            // gradient overlay
            gradientOverlayView.leftAnchor.constraint(equalTo: view.leftAnchor),
            gradientOverlayView.rightAnchor.constraint(equalTo: view.rightAnchor),
            gradientOverlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientOverlayView.topAnchor.constraint(equalTo: deviceView.eyesBottomAnchor)
        ])
    }

    private func setupMotionEffects() {
        UIView.addInterpolatingMotionEffects(
            interpolatingEffectContexts: [
                MotionEffects.verticalTiltTransformY(),
                MotionEffects.horizontalTiltTransformX()
            ],
            to: [titleLabel, infoButton]
        )
        subtitleLabel.addInterpolatingMotionEffects(
            interpolatingEffectContexts: [
                MotionEffects.verticalTiltTransformY(inverted: true),
                MotionEffects.horizontalTiltTransformX(inverted: true)
            ]
        )
    }

    private func setupBusinessLogic() {
        var counter: UInt8 = 0
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            let transformInfo: TransformInfo
            if counter >= 5 {
                counter = 0
                transformInfo = .identity
            } else {
                counter += 1
                transformInfo = self.transformInfoFactory.makeRandomTransformInfo()
            }

            UIView.animate(
                withDuration: 2.5,
                delay: 0,
                usingSpringWithDamping: 0.65,
                initialSpringVelocity: 0,
                options: []
            ) {
                self.deviceView.setEyeballsTransform(transformInfo: transformInfo)
            }
        }
    }
}

private extension LinearGradientView.Gradient {

    static let overlay: LinearGradientView.Gradient = LinearGradientView.Gradient(
        direction: CGPoint(x: 0, y: 1),
        locations: [0, 0.25, 0.75, 1],
        colors: [
            .dynamic(
                light: UIColor(white: 1, alpha: 0),
                dark: UIColor(white: 0, alpha: 0)
            ),
            .dynamic(
                light: UIColor(white: 1, alpha: 0.3),
                dark: UIColor(white: 0, alpha: 0.3)
            ),
            .dynamic(
                light: UIColor(white: 1, alpha: 0.85),
                dark: UIColor(white: 0, alpha: 0.85)
            ),
            .dynamic(
                light: UIColor(white: 1, alpha: 1),
                dark: UIColor(white: 0, alpha: 1)
            )
        ]
    )
}

private enum Constants {

    static let edgeInsets: UIEdgeInsets = sizeClassAdaptive(
        compact: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16),
        medium: UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24)
    )
    static let titleToInfoSpacing: CGFloat = 16
    static let infoToSubtitleSpacing: CGFloat = sizeClassAdaptive(compact: 24, medium: 36)
    static let subtitleToDeviceSpacing: CGFloat = sizeClassAdaptive(compact: 24, medium: 36)
    static let infoSize: CGSize = CGSize(width: 44, height: 44)
}

//
//  EyeView.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit
import EyesKit

final class EyeView: UIView {

    // MARK: - Subviews

    private let eyeballView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.foregroundMainLight
        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Instance Methods

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        self.layer.borderColor = Colors.foregroundMain.cgColor
    }

    func setEyeballTransform(transformInfo: TransformInfo) {
        eyeballView.transform = CGAffineTransform(
            translationX: transformInfo.x * bounds.width / 2,
            y: transformInfo.y * bounds.height / 2
        ).concatenating(
            CGAffineTransform(rotationAngle: transformInfo.rotationAngle)
        ).concatenating(
            CGAffineTransform(scaleX: transformInfo.scale, y: transformInfo.scale)
        )
    }

    // MARK: - Private Instance Methods

    private func setupLayout () {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 16
        self.layer.cornerCurve = .continuous
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.foregroundMain.cgColor
        self.backgroundColor = Colors.backgroundMainLight

        addSubview(eyeballView)

        NSLayoutConstraint.activate([
            eyeballView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            eyeballView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            eyeballView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: GoldenRatio.inversedCGFloatValue),
            eyeballView.heightAnchor.constraint(equalTo: eyeballView.widthAnchor)
        ])
    }
}

//
//  LinearGradientView.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

final class LinearGradientView: UIView {

    // MARK: - Nested Types

    struct Gradient {
        let direction: CGPoint
        let locations: [Float]
        let colors: [UIColor]
    }

    // MARK: - Internal Type Properties

    override class var layerClass: AnyClass { CAGradientLayer.self }

    // MARK: - Private Instance Properties

    private var gradient: Gradient?

    private var gradientLayer: CAGradientLayer? { self.layer as? CAGradientLayer }

    // MARK: - Initializers

    init(gradient: Gradient?) {
        super.init(frame: .zero)

        setupView()
        apply(gradient: gradient)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Instance Methods

    func apply(gradient: Gradient?) {
        guard let gradientLayer = gradientLayer else { return }

        self.gradient = gradient
        if let gradient = gradient {
            gradientLayer.colors = gradient.colors.map { $0.cgColor }
            gradientLayer.locations = gradient.locations.map { NSNumber(value: $0) }
            gradientLayer.startPoint = .zero
            gradientLayer.endPoint = gradient.direction
        } else {
            gradientLayer.colors = []
            gradientLayer.locations = []
            gradientLayer.startPoint = .zero
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        apply(gradient: self.gradient)
    }

    // MARK: -

    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
    }
}

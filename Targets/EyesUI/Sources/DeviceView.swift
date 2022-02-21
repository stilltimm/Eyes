//
//  DeviceView.swift
//  EyesUI
//
//  Created by Timofey Surkov on 21.02.2022.
//  Copyright © 2022 com.timofeysurkov. All rights reserved.
//

import UIKit

final class DeviceView: UIView {

    // MARK: - Subviews

    private let leftEyeView = EyeView()
    private let rightEyeView = EyeView()
    private var appPlaceholderViews: [UIView] = []

    // MARK: - Internal Instance Properties

    var eyesBottomAnchor: NSLayoutYAxisAnchor { leftEyeView.bottomAnchor }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Instance Methods

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        self.layer.borderColor = Colors.foregroundMain.cgColor

        appPlaceholderViews.forEach { view in
            view.layer.borderColor = Colors.foregroundMain.cgColor
        }
    }

    func resetEyeballsTransform() {
        leftEyeView.resetEyeballTransform()
        rightEyeView.resetEyeballTransform()
    }

    func setEyeballsTransform(
        x: CGFloat,
        y: CGFloat,
        rotationAngle: CGFloat,
        scale: CGFloat
    ) {
        leftEyeView.setEyeballTransform(x: x, y: y, rotationAngle: rotationAngle, scale: scale)
        rightEyeView.setEyeballTransform(x: x, y: y, rotationAngle: rotationAngle, scale: scale)
    }

    // MARK: - Private Instance Methods

    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerCurve = .continuous
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.foregroundMain.cgColor

        addSubview(leftEyeView)
        addSubview(rightEyeView)

        NSLayoutConstraint.activate([
            leftEyeView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.edgeInsets.left),
            leftEyeView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.edgeInsets.top),
            rightEyeView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.edgeInsets.right),
            rightEyeView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.edgeInsets.top),
            leftEyeView.rightAnchor.constraint(equalTo: rightEyeView.leftAnchor, constant: -Constants.spacing),
            leftEyeView.heightAnchor.constraint(equalTo: leftEyeView.widthAnchor),
            rightEyeView.heightAnchor.constraint(equalTo: rightEyeView.widthAnchor),
            leftEyeView.widthAnchor.constraint(equalTo: rightEyeView.widthAnchor)
        ])

        for _ in 0..<Constants.appRowsCount {
            let rowViews = makeAppPlaceholdersRowViews()
            guard !rowViews.isEmpty else { continue }

            let firstViewOfRow = rowViews[0]

            let topConstraint: NSLayoutConstraint
            if let lastViewOfPrevoiusRow = self.appPlaceholderViews.last {
                topConstraint = firstViewOfRow.topAnchor.constraint(
                    equalTo: lastViewOfPrevoiusRow.bottomAnchor,
                    constant: Constants.spacing
                )
            } else {
                topConstraint = firstViewOfRow.topAnchor.constraint(
                    equalTo: leftEyeView.bottomAnchor,
                    constant: Constants.spacing
                )
            }
            topConstraint.isActive = true

            self.appPlaceholderViews.append(contentsOf: rowViews)
        }
    }

    private func makeAppPlaceholdersRowViews() -> [UIView] {
        let views: [UIView] = (0..<Constants.appColumnsCount).map { _ in makeAppPlaceholderView() }
        views.forEach { self.addSubview($0) }

        views.enumerated().forEach { i, view in
            let leftConstraint: NSLayoutConstraint
            if i == 0 {
                leftConstraint = view.leftAnchor.constraint(equalTo: leftEyeView.leftAnchor)
            } else {
                let previousView = views[i-1]
                leftConstraint = view.leftAnchor.constraint(
                    equalTo: previousView.rightAnchor,
                    constant: Constants.spacing
                )

                view.topAnchor.constraint(equalTo: previousView.topAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: previousView.widthAnchor).isActive = true
            }
            leftConstraint.isActive = true

            if i == Constants.appColumnsCount - 1 {
                view.rightAnchor.constraint(equalTo: rightEyeView.rightAnchor).isActive = true
            }

            view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        }

        return views
    }

    private func makeAppPlaceholderView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.foregroundMain.cgColor
        view.layer.cornerRadius = 12
        view.layer.cornerCurve = .continuous
        return view
    }
}

private enum Constants {

    static let edgeInsets: UIEdgeInsets = sizeClassAdaptive(
        compact: UIEdgeInsets(top: 32, left: 32, bottom: 0, right: 32),
        medium: UIEdgeInsets(top: 40, left: 40, bottom: 0, right: 40)
    )
    static let cornerRadius: CGFloat = sizeClassAdaptive(compact: 48, medium: 56)
    static let spacing: CGFloat = sizeClassAdaptive(compact: 16, medium: 18)

    static let appColumnsCount: Int = 4
    static let appRowsCount: Int = sizeClassAdaptive(compact: 3, medium: 4, wide: 5)
}

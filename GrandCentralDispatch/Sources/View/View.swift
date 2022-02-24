//
//  View.swift
//  GrandCentralDispatch
//
//  Created by Евгений Ганусенко on 2/24/22.
//
import UIKit

class SettingsView: UIView {

    // MARK: - Properties
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        return stack
    }()

    var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = ViewConstants.infoLabelNumberOfLines
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: ViewConstants.infoLabelFont)
        return label
    }()

    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        return indicator
    }()

    var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = ViewConstants.textFieldLayerCornerRadius
        textField.isSecureTextEntry = true
        return textField
    }()

    var buttonColorReplacement: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = ViewConstants.buttonColorReplacementLayerCornerRadius
        button.setTitle("Сменим цвет?", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        button.isHidden = true
        return button
    }()

    var changeStatusButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.layer.cornerRadius = ViewConstants.changeStatusButtonCornerRadius
        button.backgroundColor = .blue
        return button
    }()

    // MARK: - SetupHierarchy
    func setupHierarchy() {
        addSubview(stackView)
        stackView.addSubview(activityIndicator)
        stackView.addSubview(textField)
        stackView.addSubview(infoLabel)
        stackView.addSubview(changeStatusButton)
        stackView.addSubview(buttonColorReplacement)
    }

    // MARK: - Initial
    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    // MARK: - SetupLayout
    func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        changeStatusButton.translatesAutoresizingMaskIntoConstraints = false
        buttonColorReplacement.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: ViewConstants.stackViewTopAndLeadingAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: ViewConstants.stackViewTopAndLeadingAnchor),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: ViewConstants.stackViewTrailingAndBottomAnchor),
            stackView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: ViewConstants.stackViewTrailingAndBottomAnchor),

            activityIndicator.topAnchor.constraint(
                equalTo: stackView.topAnchor,
                constant: ViewConstants.activityIndicatorTopAnchorConstraint),
            activityIndicator.leadingAnchor.constraint(
                equalTo: stackView.leadingAnchor,
                constant: ViewConstants.activityIndicatorLeadingAnchorConstraint),
            activityIndicator.trailingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: ViewConstants.activityIndicatorTrailingAnchorConstraint),

            textField.topAnchor.constraint(
                equalTo: activityIndicator.bottomAnchor,
                constant: ViewConstants.textFieldTopAnchorConstraint),
            textField.leadingAnchor.constraint(
                equalTo: stackView.leadingAnchor,
                constant: ViewConstants.textFieldLeadingAnchorConstraint),
            textField.trailingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: ViewConstants.textFieldTrailingAnchorConstraint),

            changeStatusButton.topAnchor.constraint(
                equalTo: textField.bottomAnchor,
                constant: ViewConstants.changeStatusButtonTopAnchorConstraint),
            changeStatusButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            changeStatusButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),

            infoLabel.topAnchor.constraint(
                equalTo: changeStatusButton.bottomAnchor,
                constant: ViewConstants.infoLabelTopAnchorConstraint),
            infoLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),

            buttonColorReplacement.topAnchor.constraint(
                equalTo: infoLabel.bottomAnchor,
                constant: ViewConstants.buttonColorReplacementTopAnchorConstraint),
            buttonColorReplacement.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            buttonColorReplacement.trailingAnchor.constraint(equalTo: textField.trailingAnchor),

        ])
    }
}

// MARK: - Constants
struct ViewConstants {
    static let stackViewTopAndLeadingAnchor: CGFloat = 8
    static let stackViewTrailingAndBottomAnchor: CGFloat = -8

    static let activityIndicatorTopAnchorConstraint: CGFloat = 200
    static let activityIndicatorLeadingAnchorConstraint: CGFloat = 100
    static let activityIndicatorTrailingAnchorConstraint: CGFloat = -100

    static let infoLabelNumberOfLines: Int = 3
    static let infoLabelFont: CGFloat = 15
    static let infoLabelTopAnchorConstraint: CGFloat = 10

    static let textFieldLayerCornerRadius: CGFloat = 6
    static let textFieldTopAnchorConstraint: CGFloat = 50
    static let textFieldLeadingAnchorConstraint: CGFloat = 100
    static let textFieldTrailingAnchorConstraint: CGFloat = -100

    static let buttonColorReplacementLayerCornerRadius: CGFloat = 5
    static let buttonColorReplacementTopAnchorConstraint: CGFloat = 10

    static let changeStatusButtonCornerRadius: CGFloat = 5
    static let changeStatusButtonTopAnchorConstraint: CGFloat = 10
}

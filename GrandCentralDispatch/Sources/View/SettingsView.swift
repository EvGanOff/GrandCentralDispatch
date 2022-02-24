//
//  SettingsView.swift
//  GrandCentralDispatch
//
//  Created by Евгений Ганусенко on 2/24/22.
//
import UIKit

class SettingsView: UIView {
    // MARK: - Properties
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        return stack
    }()

    private var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "тут будет меняться текст"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = false
        return indicator
    }()

    private var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 6
        textField.isSecureTextEntry = true
        return textField
    }()

    private var buttonColorReplacement: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle("Сменим цвет?", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        return button
    }()

    private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Взлом", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = .blue
        return button
    }()

    // MARK: - SetupHierarchy
    func setupHierarchy() {
        addSubview(stackView)
        stackView.addSubview(activityIndicator)
        stackView.addSubview(textField)
        stackView.addSubview(infoLabel)
        stackView.addSubview(button)
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
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonColorReplacement.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            activityIndicator.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 200),
            activityIndicator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 100),
            activityIndicator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -100),

            textField.topAnchor.constraint(equalTo: activityIndicator.topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 100),
            textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -100),

            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textField.trailingAnchor),

            infoLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),

            buttonColorReplacement.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            buttonColorReplacement.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            buttonColorReplacement.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
    }
}

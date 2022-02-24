//
//  ViewController.swift
//  GrandCentralDispatch
//
//  Created by Евгений Ганусенко on 2/23/22.
//

import UIKit

class ViewController: UIViewController {

   // MARK: - Properties
    var onboardingView: SettingsView? {
        guard isViewLoaded else { return nil }
        return view as? SettingsView
    }

    // MARK: - Сomputed properties
    private var isBlack: Bool = true {
        didSet {
            if isBlack {
                changeObjectsColor(isBlack: isBlack)
            } else {
                changeObjectsColor(isBlack: isBlack)
            }
        }
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view = SettingsView()
        configurate(status: .start)
        onboardingView?.changeStatusButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        onboardingView?.buttonColorReplacement.addTarget(self, action: #selector(tapButtonColorChange), for: .touchUpInside)
        
    }
}

extension ViewController {

    // MARK: - Action object changes
    @objc func tapButton() {
        configurate(status: .process)
        let password = onboardingView?.textField.text ?? ""
        let queue = OperationQueue()
        let passwordArray = password.components(withMaxLength: ViewControllerConstants.stringWithMaxLength)
        var operation = [GenerateBruteForceOperation]()
        for password in passwordArray {
            operation.append(GenerateBruteForceOperation(password: password))
        }
        for force in operation {
            queue.addOperation(force)
        }

        queue.addBarrierBlock { [weak self] in
            DispatchQueue.main.async {
                self?.configurate(status: .finished)
            }
        }
    }

    @objc func tapButtonColorChange() {
        isBlack.toggle()
    }

    private func changeObjectsColor (isBlack: Bool) {
        switch isBlack {
        case false:
            self.view.backgroundColor = .black
            self.onboardingView?.infoLabel.textColor = .white
            self.onboardingView?.buttonColorReplacement.backgroundColor = .systemPink
        case true:
            self.view.backgroundColor = .white
            self.onboardingView?.infoLabel.textColor = .black
            self.onboardingView?.buttonColorReplacement.backgroundColor = .systemOrange
        }
    }

    private func configurate(status: Status) {
        switch status {
        case .start:
            onboardingView?.infoLabel.text = "Произвести взлом?"
            onboardingView?.changeStatusButton.setTitle("Взлом", for: .normal)
        case .process:
            onboardingView?.infoLabel.text = "Выполняется взлом. Это не займет много времени..."
            onboardingView?.textField.text = String.generateRandom(long: ViewControllerConstants.textFieldMaxRandomElements)
            onboardingView?.activityIndicator.isHidden = false
            onboardingView?.activityIndicator.startAnimating()
            onboardingView?.textField.isSecureTextEntry = true
            onboardingView?.buttonColorReplacement.isHidden = false
            onboardingView?.changeStatusButton.isUserInteractionEnabled = false
            onboardingView?.changeStatusButton.setTitle("Взламываю...", for: .normal)
        case .finished:
            onboardingView?.activityIndicator.isHidden = true
            onboardingView?.activityIndicator.stopAnimating()
            onboardingView?.textField.isSecureTextEntry = false
            onboardingView?.infoLabel.text = "Пароль \(self.onboardingView?.textField.text ?? "")"
            onboardingView?.changeStatusButton.isSelected = false
            onboardingView?.buttonColorReplacement.isHidden = true
            onboardingView?.changeStatusButton.isUserInteractionEnabled = true
            onboardingView?.changeStatusButton.setTitle("Повтор", for: .normal)
        }
    }
}

// MARK: - Cnstants
struct ViewControllerConstants {
    static let stringWithMaxLength: Int = 3
    static let textFieldMaxRandomElements: Int = 10
}


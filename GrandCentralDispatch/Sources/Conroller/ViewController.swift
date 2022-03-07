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

    var brute = GenerateBruteForceOperation()

    // MARK: - Сomputed properties
    private var isBlack: Bool = true {
        didSet {
            onboardingView?.backgroundColor = isBlack ? .white : .black
            onboardingView?.infoLabel.textColor = isBlack ? .black : .white
            onboardingView?.buttonColorReplacement.backgroundColor = isBlack ? .systemOrange : .systemPink
        }
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = SettingsView()
        statusChange(for: .start)
        onboardingView?.changeStatusButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        onboardingView?.buttonColorReplacement.addTarget(self, action: #selector(tapButtonColorChange), for: .touchUpInside)
    }
}

extension ViewController {

    // MARK: - Action object changes
    @objc func tapButton() {
        statusChange(for: .progress)
        let unlockPassword = String().generatePassword()
        onboardingView?.textField.text = unlockPassword
        let queue = DispatchQueue(label: "MyBruteForce", qos: .default, attributes: .concurrent)
        let bruteForce = DispatchWorkItem { [self] in
            brute.bruteForce(passwordToUnlock: unlockPassword)
        }

        bruteForce.notify(queue: .main) { [self] in
            statusChange(for: .finish)
        }
        
        queue.async(execute: bruteForce)
    }

    @objc func tapButtonColorChange() {
        isBlack.toggle()
    }

    func statusChange(for value: Status) {
        switch value {
        case .start:
            onboardingView?.infoLabel.text = "Произвести взлом?"
            onboardingView?.changeStatusButton.setTitle("Взлом", for: .normal)
        case .progress:
            onboardingView?.infoLabel.text = "Выполняется взлом. Это не займет много времени..."
            onboardingView?.activityIndicator.isHidden = false
            onboardingView?.activityIndicator.startAnimating()
            onboardingView?.textField.isSecureTextEntry = true
            onboardingView?.buttonColorReplacement.isHidden = false
            onboardingView?.changeStatusButton.isUserInteractionEnabled = false
            onboardingView?.changeStatusButton.setTitle("Взламываю...", for: .normal)
        case .finish:
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



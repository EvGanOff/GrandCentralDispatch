//
//  ViewController.swift
//  GrandCentralDispatch
//
//  Created by Евгений Ганусенко on 2/23/22.
//

import UIKit

class ViewController: UIViewController {

   // MARK: - Properties
    var onboardingBrutView: BruteView? {
        guard isViewLoaded else { return nil }
        return view as? BruteView
    }

    var brute = GenerateBruteForceOperation()

    // MARK: - Сomputed properties
    private var isBlack: Bool = true {
        didSet {
            onboardingBrutView?.backgroundColor = isBlack ? .white : .black
            onboardingBrutView?.infoLabel.textColor = isBlack ? .black : .white
            onboardingBrutView?.buttonColorReplacement.backgroundColor = isBlack ? .systemOrange : .systemPink
        }
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = BruteView()
        statusChange(for: .start)
        onboardingBrutView?.changeStatusButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        onboardingBrutView?.buttonColorReplacement.addTarget(self, action: #selector(tapButtonColorChange), for: .touchUpInside)
    }
}

extension ViewController {

    // MARK: - Action object changes
    @objc func tapButton() {
        statusChange(for: .progress)
        onboardingBrutView?.textField.text = String().generatePassword()
        let unlockPassword = onboardingBrutView?.textField.text?.components(withMaxLength: 3) ?? [""]
        let queue = DispatchQueue(label: "MyBruteForce", qos: .default, attributes: .concurrent)
        let bruteForce = DispatchWorkItem { [self] in
            for character in unlockPassword {
                brute.bruteForce(passwordToUnlock: character)
            }
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
            onboardingBrutView?.infoLabel.text = "Произвести взлом?"
            onboardingBrutView?.changeStatusButton.setTitle("Взлом", for: .normal)
        case .progress:
            onboardingBrutView?.infoLabel.text = "Выполняется взлом. Это не займет много времени..."
            onboardingBrutView?.activityIndicator.isHidden = false
            onboardingBrutView?.activityIndicator.startAnimating()
            onboardingBrutView?.textField.isSecureTextEntry = true
            onboardingBrutView?.buttonColorReplacement.isHidden = false
            onboardingBrutView?.changeStatusButton.isUserInteractionEnabled = false
            onboardingBrutView?.changeStatusButton.setTitle("Взламываю...", for: .normal)
        case .finish:
            onboardingBrutView?.activityIndicator.isHidden = true
            onboardingBrutView?.activityIndicator.stopAnimating()
            onboardingBrutView?.textField.isSecureTextEntry = false
            onboardingBrutView?.infoLabel.text = "Пароль \(self.onboardingBrutView?.textField.text ?? "")"
            onboardingBrutView?.changeStatusButton.isSelected = false
            onboardingBrutView?.buttonColorReplacement.isHidden = true
            onboardingBrutView?.changeStatusButton.isUserInteractionEnabled = true
            onboardingBrutView?.changeStatusButton.setTitle("Повтор", for: .normal)
        }
    }
}



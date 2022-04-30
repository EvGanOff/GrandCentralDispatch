//
//  ViewController.swift
//  GrandCentralDispatch
//
//  Created by Евгений Ганусенко on 2/23/22.
//

import UIKit

class ViewController: UIViewController {

   // MARK: - Properties
    var brutView: BruteView? {
        guard isViewLoaded else { return nil }
        return view as? BruteView
    }

    var brute = GenerateBruteForceOperation()

    // MARK: - Сomputed properties
    private var isBlack: Bool = true {
        didSet {
            brutView?.backgroundColor = isBlack ? .white : .black
            brutView?.infoLabel.textColor = isBlack ? .black : .white
            brutView?.buttonColorReplacement.backgroundColor = isBlack ? .systemOrange : .systemPink
        }
    }

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = BruteView()
        statusChange(for: .start)
        brutView?.changeStatusButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        brutView?.buttonColorReplacement.addTarget(self, action: #selector(tapButtonColorChange), for: .touchUpInside)
    }
}

extension ViewController {

    // MARK: - Action object changes
    @objc func tapButton() {
        statusChange(for: .progress)
        brutView?.textField.text = String().generatePassword()
        let unlockPassword = brutView?.textField.text?.components(withMaxLength: 3) ?? [""]
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
            brutView?.infoLabel.text = "Произвести взлом?"
            brutView?.changeStatusButton.setTitle("Взлом", for: .normal)
        case .progress:
            brutView?.infoLabel.text = "Выполняется взлом. Это не займет много времени..."
            brutView?.activityIndicator.isHidden = false
            brutView?.activityIndicator.startAnimating()
            brutView?.textField.isSecureTextEntry = true
            brutView?.buttonColorReplacement.isHidden = false
            brutView?.changeStatusButton.isUserInteractionEnabled = false
            brutView?.changeStatusButton.setTitle("Взламываю...", for: .normal)
        case .finish:
            brutView?.activityIndicator.isHidden = true
            brutView?.activityIndicator.stopAnimating()
            brutView?.textField.isSecureTextEntry = false
            brutView?.infoLabel.text = "Пароль \(self.brutView?.textField.text ?? "")"
            brutView?.changeStatusButton.isSelected = false
            brutView?.buttonColorReplacement.isHidden = true
            brutView?.changeStatusButton.isUserInteractionEnabled = true
            brutView?.changeStatusButton.setTitle("Повтор", for: .normal)
        }
    }
}



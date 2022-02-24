//
//  ViewController.swift
//  GrandCentralDispatch
//
//  Created by Евгений Ганусенко on 2/23/22.
//

import UIKit

class ViewController: UIViewController {

    private var onboardingView: SettingsView? {
        guard isViewLoaded else { return nil }
        return view as? SettingsView
    }

   private var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = SettingsView()
    }
}

extension ViewController {
    
}


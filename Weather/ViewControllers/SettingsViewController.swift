//
//  SettingsViewController.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet weak var farenheitButton: UIButton!
    @IBOutlet weak var celsiusButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        farenheitButton.layer.borderWidth = 1
        farenheitButton.layer.borderColor = UIColor.black.cgColor
        celsiusButton.layer.borderWidth = 1
        celsiusButton.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func celsiusAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.celcius.rawValue)
    }
    
    @IBAction func farenheitAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.celcius.rawValue)
    }
}

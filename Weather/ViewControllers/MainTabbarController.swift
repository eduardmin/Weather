//
//  MainTabbarController.swift
//  Weather
//
//  Created by Eduard Minasyan on 24.09.23.
//

import UIKit

class MainTabbarController: UITabBarController {
    private let defaultIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }

}

//
//  BaseViewController.swift
//  Weather
//
//  Created by Eduard Minasyan on 24.09.23.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainColor
    }

    func bindViewModel() { }
    
    func startLoading() {
        LoadingIndicator.show(on: view)
    }
    
    func stopLoading() {
        LoadingIndicator.hide(from: view)
    }
}

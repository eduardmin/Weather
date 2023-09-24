//
//  BaseViewModel.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import Foundation
import Combine

public enum LoadingState: Equatable {
    case loaded
    case loading
    case error(String?, isAlertStyle: Bool = true)
    case notLoaded
}

class BaseViewModel {
    @Published var state: LoadingState = .notLoaded
    @Published var saveState: LoadingState = .notLoaded
    var cancellables = Set<AnyCancellable>()
    init() {
        
    }
}

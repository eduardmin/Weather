//
//  Paths.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import Foundation

class Paths {
    //MARK:- Base URLs
    static let apiKey = "f38aa18fd8b98e11156b59b834c19109"
    static var baseUrl: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    static let weather = baseUrl + "/weather"
    static let forecast = baseUrl + "/forecast/daily"
}

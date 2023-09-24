//
//  ForeCastViewModel.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import Foundation

class ForecastViewModel: BaseViewModel {
    
    var forecast: ForeCastModel?
    // not making request because need subscription
    override init() {
        super.init()
        getModel()
    }
    
    private func getModel() {
        if let path = Bundle.main.path(forResource: "forecast", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                let model: ForeCastModel? = try? JSONDecoder().decode(ForeCastModel.self, from: jsonData as Data)
                self.forecast = model
            }
        }
    }
    
    func temperature(indexPath: IndexPath) -> String? {
        if let isCelcius = UserDefaults.standard.object(forKey: UserDefaultsKey.celcius.rawValue) as? Bool, !isCelcius {
            if let fahrenheit = forecast?.list[indexPath.row].temp.tempFahrenheit {
                return "\(fahrenheit.rounded()) °F"
            }
        }
        if let celsius = forecast?.list[indexPath.row].temp.tempCelsius {
            return "\(celsius.rounded()) C°"
        }
        return nil
    }
    
    func weatherIcon(indexPath: IndexPath) -> String? {
        return forecast?.list[indexPath.row].weather.first?.icon
    }
}

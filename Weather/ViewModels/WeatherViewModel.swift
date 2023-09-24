//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Eduard Minasyan on 24.09.23.
//

import Foundation

enum WeatherErrorType: String {
    case location
    case network
}

class WeatherViewModel: BaseViewModel {
    private let locationManager = LocationManager()
    var cityName: String? {
        return locationManager.locationModel?.cityName
    }
    private var weatherModel: WeatherModel?
    private var currentCity: String?
    override init() {
        super.init()
        bindModel()
    }
    
    func bindModel() {
        locationManager.$locationModel.sink { [weak self] model in
            guard let self = self else { return }
            if let model = model, let cityName = model.cityName {
                self.getWeather(cityName: cityName)
            }
        }.store(in: &cancellables)
        
        locationManager.$error.sink { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                self.state = .error(WeatherErrorType.location.rawValue, isAlertStyle: false)
            }
        }.store(in: &cancellables)
    }
    
    func getWeather(cityName: String) {
        self.currentCity = cityName
        let webservice = WeatherWebService()
        webservice.getWeather(cityName: cityName) { [weak self] data, error in
            guard let self = self else { return }
            if error != nil {
                self.state = .error(WeatherErrorType.network.rawValue, isAlertStyle: false)
                return
            }
            
            if let data = data {
                self.handleResponse(data: data)
            }
        }
    }
    
    func update() {
        if let currentCity = currentCity {
            getWeather(cityName: currentCity)
        }
    }
    
    func getCityName() -> String? {
        return weatherModel?.name
    }
    
    func temperature() -> String? {
        if let isCelcius = UserDefaults.standard.object(forKey: UserDefaultsKey.celcius.rawValue) as? Bool, !isCelcius {
            if let fahrenheit = weatherModel?.main.tempFahrenheit {
                return "\(fahrenheit.rounded()) °F"
            }
        }
        if let celsius = weatherModel?.main.tempCelsius {
            return "\(celsius.rounded()) C°"
        }
        return nil
    }
    
    func weatherIcon() -> String? {
        return weatherModel?.weather.first?.icon
    }
    
    func comments() -> [CommentModel]? {
        return weatherModel?.comments
    }
}

extension WeatherViewModel {
    func handleResponse(data: Data) {
        let model: WeatherModel? = try? JSONDecoder().decode(WeatherModel.self, from: data)
        self.weatherModel = model
        state = .loaded
    }
    
    
}

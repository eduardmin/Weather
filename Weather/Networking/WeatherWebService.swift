//
//  WeatherWebService.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import Foundation

class WeatherWebService: BaseNetworkManager {
    
    func getWeather(cityName: String, compilation: @escaping (Data?, NetworkError?) -> ()) {
        var param = [String: Any]()
        param["q"] = cityName
        param["appid"] = Paths.apiKey
        sendGetRequest(path: Paths.weather, parameters: param) { data, error in
            if error != nil {
                compilation(nil, error)
                return
            }
            if let data = data as? Data  {
                compilation(data, nil)
            }
        }
    }
    
    //NEED pay for this api https://openweathermap.org/api
    func getForecastWeather(cityName: String, days: Int, compilation: @escaping (Data?, NetworkError?) -> ()) {
        var param = [String: Any]()
        param["q"] = cityName
        param["cnt"] = days
        param["appid"] = Paths.apiKey
        sendGetRequest(path: Paths.forecast, parameters: param) { data, error in
            if error != nil {
                compilation(nil, error)
                return
            }
            if let data = data as? Data  {
                compilation(data, nil)
            }
        }
    }
}

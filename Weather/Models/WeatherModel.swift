//
//  WeatherModel.swift
//  Weather
//
//  Created by Eduard Minasyan on 25.09.23.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
    
    var comments: [CommentModel] {
        var comments = [CommentModel]()
        if main.tempCelsius < 0 {
            comments.append(CommentModel(message: "Temperature less than 0 degrees"))
        } else if main.tempCelsius >= 0 && 15 <= main.tempCelsius {
            comments.append(CommentModel(message:"temperature from 0 to 15 degrees"))
        } else {
            comments.append(CommentModel(message:"temperature above 15 degrees"))
        }
        comments.append(CommentModel(message:"Visibility \(visibility)"))
        comments.append(CommentModel(message:"Wind speed \(wind.speed)"))
        return comments
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    var tempCelsius: Double {
        return temp - 273.15
    }
    
    var tempFahrenheit: Double {
        return (temp - 273.15) * 1.8 + 32
    }
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct CommentModel {
    var message: String
}

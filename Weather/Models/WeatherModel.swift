//
//  WeatherModel.swift
//  Weather
//
//  Created by Nikita on 10.12.2023.
//

import Foundation

struct WeatherModel {
    
    let city: String
    let temp: Double
    let id: Int
    let description: String
    let minTemp: Double
    let maxTemp: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temp)
    }
    
    var imageName: String {
        switch id {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.sleet.fill"
        case 701...781:
            return "smoke"
        case 800:
            return "sun.max.fill"
        case 801...805:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
}

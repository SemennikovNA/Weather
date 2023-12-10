//
//  AdvancedWeatherModel.swift
//  Weather
//
//  Created by Nikita on 10.12.2023.
//

import Foundation

// MARK: - Weather

struct AdvancedWeather: Codable {
    
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]
    let hourly: [Current]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily
    }
}

// MARK: - Current

struct Current: Codable {
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherElement]
    let snow: Snow?
    let pop: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, snow, pop
    }
}

// MARK: - Snow

struct Snow: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
//    let main: Main
    let description: Description
    let icon: Icon
}

enum Description: String, Codable {
    case lightSnow = "light snow"
    case overcastClouds = "overcast clouds"
    case snow = "snow"
}

enum Icon: String, Codable {
    case the04D = "04d"
    case the04N = "04n"
    case the13D = "13d"
    case the13N = "13n"
}

//enum Main: String, Codable {
//    case clouds = "Clouds"
//    case snow = "Snow"
//}

// MARK: - Daily

struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let summary: String
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherElement]
    let clouds, pop: Int
    let snow, uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case summary, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, snow, uvi
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt: Int
    let precipitation: Double
}

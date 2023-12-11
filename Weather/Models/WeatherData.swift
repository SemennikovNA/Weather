//
//  WeatherData.swift
//  Weather
//
//  Created by Nikita on 10.12.2023.
//

import Foundation

struct WeatherData: Codable {
    
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let name: String
    
}

struct Coord: Codable {
    
    let lon: Double
    let lat: Double
    
}

struct Weather: Codable {
    
    let id: Int
    let main: String
    let description: String?
    let icon: String
    
}

struct Main: Codable {
    
    let temp: Double
    
}

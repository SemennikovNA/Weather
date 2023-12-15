//
//  WeatherManager.swift
//  Weather
//
//  Created by Nikita on 10.12.2023.
//

import Foundation
import CoreLocation

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didUpdateAdvancedWeather(_ weatherManager: WeatherManager, dailyForecast: [DailyWeather]?, hourlyForecast: [HourlyForecast]?)
    func didFailWithError(_ error: Error)
}

class WeatherManager {

    //MARK: - Properties

    let session = URLSession(configuration: .default)
    let decode = JSONDecoder()
    var delegate: WeatherDelegate?
    private lazy var apiKey = "23779bbe7c1be50053bd8cfa59a3ddd7"
    private lazy var url = "https://api.openweathermap.org/data/2.5/weather?units=metric&lang=ru"
    private lazy var urlToLocation = "https://api.openweathermap.org/data/3.0/onecall?&units=metric&exclude=dayli"

    //MARK: - Methods

    func getURLForCity(city: String) {
        guard let urlString = URL(string: "\(url)&appid=\(apiKey)&q=\(city)") else { return }
        self.requestWeather(urlString)
    }

    func getCoordinate(lat: Double, lon: Double) {
        guard let urlString = URL(string: "\(urlToLocation)&lat=\(lat)&lon=\(lon)&appid=\(apiKey)") else { return }
        self.requestAdvancedWeather(urlString)
    }

    func requestWeather(_ urlString: URL) {
        let task = session.dataTask(with: urlString) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(error)
                return
            }

            guard let safeData = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.delegate?.didFailWithError(error)
                return
            }

            if let weather = self.parseMainWeatherJSON(weatherData: safeData) {
                self.delegate?.didUpdateWeather(self, weather: weather)
            }
        }
        task.resume()
    }

    func requestAdvancedWeather(_ urlString: URL) {
        let task = session.dataTask(with: urlString) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(error)
                return
            }

            guard let safeData = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self.delegate?.didFailWithError(error)
                return
            }

            do {
                let decodedData = try self.decode.decode(AdvancedWeather.self, from: safeData)

                let hourlyForecast = decodedData.hourly.map { hourly in
                    return HourlyForecast(time: hourly.dt, temperature: hourly.temp, id: hourly.weather[0].id)
                }

                let dailyForecast = decodedData.daily.map { daily in
                    return DailyWeather(day: daily.dt, minTemp: daily.temp.min, maxTemp: daily.temp.max, id: daily.weather[0].id)
                }

                self.delegate?.didUpdateAdvancedWeather(self, dailyForecast: dailyForecast, hourlyForecast: hourlyForecast)
            } catch {
                self.delegate?.didFailWithError(error)
            }
        }

        task.resume()
    }

    private func parseMainWeatherJSON(weatherData: Data) -> WeatherModel? {
        do {
            let decodedData = try decode.decode(WeatherData.self, from: weatherData)
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            getCoordinate(lat: lat, lon: lon)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let weather = WeatherModel(city: name, temp: temp, id: id, description: description!)
            return weather
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}


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
    func didUpdateAdvancedWeather(_ weatherManager: WeatherManager, weather: AdvancedWeatherModel, hourlyForecast: [HourlyForecast]?)
    func didFailWithError(_ error: Error)
}


class WeatherManager {
    
    //MARK: - Properties
    
    let session = URLSession(configuration: .default)
    let decode = JSONDecoder()
    var delegate: WeatherDelegate?
    private lazy var apiKey = "23779bbe7c1be50053bd8cfa59a3ddd7"
    private lazy var url = "https://api.openweathermap.org/data/2.5/weather?units=metric&lang=ru"
    private lazy var urlToLocation = "https://api.openweathermap.org/data/3.0/onecall?&exclude=dayli&units=metric"
    
    //MARK: - Methods
    
    func getURLForCity(city: String) {
        guard let urlString = URL(string: "\(url)&appid=\(apiKey)&q=\(city)") else { return }
        self.requestWeather(urlString)
    }
    
    func getCoordinate(lat: Double, lon: Double) {
        guard let urlString = URL(string: "\(urlToLocation)&appid=\(apiKey)&lat=\(lat)&lon=\(lon)") else { return }
        print(urlString)
        self.requestAdvancedWeather(urlString)
    }
    
    func requestWeather(_ urlString: URL) {
        let task = session.dataTask(with: urlString) { data, responce, error in
            if error != nil {
                print(error!)
            }
            
            if let safeData = data {
                if let weather = self.parseMainWeatherJSON(weathedData: safeData) {
                    self.delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        task.resume()
    }
    
    func requestAdvancedWeather(_ urlString: URL) {
        let task = session.dataTask(with: urlString) { data, response, error in
            if error != nil {
                print(error!)
                self.delegate?.didFailWithError(error!)
                return
            }

            if let safeData = data {
                do {
                    let decodedData = try self.decode.decode(AdvancedWeather.self, from: safeData)

                    let hourlyForecast = decodedData.hourly.map { hourly in
                        return HourlyForecast(time: hourly.dt, temperature: hourly.temp, id: hourly.weather[0].id)
                    }

                    let day = decodedData.daily[0].dt
                    let minTemp = decodedData.daily[0].temp.min
                    let maxTemp = decodedData.daily[0].temp.max
                    let id = decodedData.daily[0].weather[0].id
                    let advancedWeather = AdvancedWeatherModel(day: day, minTemp: minTemp, maxTemp: maxTemp, id: id)

                    self.delegate?.didUpdateAdvancedWeather(self, weather: advancedWeather, hourlyForecast: hourlyForecast)
                } catch {
                    self.delegate?.didFailWithError(error)
                }
            }
        }

        task.resume()
    }
    
   private func parseMainWeatherJSON(weathedData: Data) -> WeatherModel? {
        do {
            let decodedData = try decode.decode(WeatherData.self, from: weathedData)
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
    
    private func parseAdvancedWeather(weatherData: Data) -> AdvancedWeatherModel? {
        do {
            let decodeData = try decode.decode(AdvancedWeather.self, from: weatherData)

            let hourlyForecast = decodeData.hourly.map { hourly in
                return HourlyForecast(time: hourly.dt, temperature: hourly.temp, id: hourly.weather[0].id)
            }
            let day = decodeData.daily[0].dt
            let minTemp = decodeData.daily[0].temp.min
            let maxTemp = decodeData.daily[0].temp.max
            let id = decodeData.daily[0].weather[0].id
            let advance = AdvancedWeatherModel(day: day, minTemp: minTemp, maxTemp: maxTemp, id: id)

            delegate?.didUpdateAdvancedWeather(self, weather: advance, hourlyForecast: hourlyForecast)
            return advance
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}

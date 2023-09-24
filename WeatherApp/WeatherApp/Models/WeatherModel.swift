//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Robert Shrestha on 9/22/23.
//

import Foundation
struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double?
    let humidity: Double?

    static var placeholder: Weather {
        return Weather(temp: nil, humidity: nil)
    }
}

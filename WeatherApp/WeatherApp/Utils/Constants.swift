//
//  Constants.swift
//  WeatherApp
//
//  Created by Robert Shrestha on 9/22/23.
//

import Foundation

import Foundation

struct Constants {
    struct URLs {
        static func weather(city: String) -> String {
            //return "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7d2dd8c9c5578b741c7735ad3f0d39ea&units=imperial"\
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=72e19afac6bcb9860966c7215441834d&units=imperial"
        }
    }
}

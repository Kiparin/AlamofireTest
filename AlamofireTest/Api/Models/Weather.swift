//
//  Weather.swift
//  AlamofireTest
//
//  Created by Alexey Kiparin on 29.12.2024.
//
///  Комментарий:
///		Искренне не понимаю, почему все модели должны храниться в 1 файле.
///		Как миниму это затрудняет ее поиск в проекте, Как максимум рано или поздно это привратится в огромный склад, где точно ничего не понятно

import Foundation

struct Weather: Decodable {
	let longitude: Double
	let latitude: Double
	let timezone: String
	let curentUnits: CurrentUnits
	let current: Current
	
	enum CodingKeys: String, CodingKey {
		case longitude = "longitude"
		case latitude = "latitude"
		case timezone = "timezone"
		case curentUnits = "current_units"
		case current = "current"
	}
	
	init(longitude: Double, latitude: Double, timezone: String, curentUnits: CurrentUnits, current: Current) {
		self.longitude = longitude
		self.latitude = latitude
		self.timezone = timezone
		self.curentUnits = curentUnits
		self.current = current
	}
	
	init?(weatherData: [String: Any]){
		longitude = weatherData["longitude"] as? Double ?? 0
		latitude = weatherData["latitude"] as? Double ?? 0
		timezone = weatherData["timezone"] as? String ?? ""
		
		guard let currentValue = weatherData["current"] as? [String: Any] else { return nil}
		current = Current(currentData: currentValue)
		
		guard let currentUnitsValue = weatherData["current_units"] as? [String: Any] else { return nil}
		curentUnits = CurrentUnits(currentUnitsData: currentUnitsValue)
	}
	
	static func getWeather(from value: Any) -> Weather? {
		guard let weatherValue = value as? [String: Any] else { return nil}
		return Weather(weatherData: weatherValue)
	}
	
}

struct CurrentUnits: Decodable {
	let timeType: String
	let temperatureType: String
	
	enum CodingKeys: String, CodingKey {
		case timeType = "time"
		case temperatureType = "temperature_2m"
	}
	
	init(timeType: String, temperatureType: String){
		self.timeType = timeType
		self.temperatureType = temperatureType
	}
	
	init(currentUnitsData: [String: Any]){
		timeType = currentUnitsData["time"] as? String ?? ""
		temperatureType = currentUnitsData["temperature_2m"] as? String ?? ""
	}
}

struct Current: Decodable {
	let time: String
	let temperatureNow: Double
	let isDay: Int
	let weatherCode: Int
	
	enum CodingKeys: String, CodingKey {
		case time = "time"
		case temperatureNow = "temperature_2m"
		case isDay = "is_day"
		case weatherCode = "weather_code"
	}
	
	init(time: String,temperatureNow: Double, isDay: Int, weatherCode: Int){
		self.time = time
		self.temperatureNow = temperatureNow
		self.isDay = isDay
		self.weatherCode = weatherCode
	}
	
	init(currentData: [String: Any]){
		time = currentData["time"] as? String ?? ""
		temperatureNow = currentData["temperature_2m"] as? Double ?? 0
		isDay = currentData["is_day"] as? Int ?? 0
		weatherCode = currentData["weather_code"] as? Int ?? 0
	}
}

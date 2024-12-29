//
//  Url.swift
//  AlamofireTest
//
//  Created by Alexey Kiparin on 29.12.2024.
//

enum Url {
	case weatherNow
	
	
	var urlString: String {
		switch self {
		case .weatherNow:
			return "https://api.open-meteo.com/v1/forecast?latitude=56.52&longitude=44.0354&current=temperature_2m,is_day,weather_code"
		}
	}
}

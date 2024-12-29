//
//  NetworkManager.swift
//  AlamofireTest
//
//  Created by Alexey Kiparin on 29.12.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
	
	public static let shared = NetworkManager()
	
	private init() {}
	
	
	func fetchWeatherNow(from urlString: String, completion: @escaping (Result<Weather?, AFError>) -> Void){
		AF.request(urlString)
			.validate()
			.responseJSON{ dataResponse in
				switch dataResponse.result {
				case .success(let value):
					let weather = Weather.getWeather(from: value)
					if weather == nil {
						print("Error parsing JSON")
						completion(.failure(.requestAdaptationFailed(error: "Error parsing JSON" as! Error)))
					}
					else {
						print("Successfully parsed JSON")
						completion(.success(weather))
					}
				case .failure(let error):
					completion(.failure(error))
				}
			}
	}
	
	func fetchWeatherNowAutomatic(from: String,completion: @escaping (Result<Weather, AFError>) -> Void){
		AF.request(from)
			.validate()
			.responseDecodable(of: Weather.self){ dataResponse in
				switch dataResponse.result{
				case .success(let value):
					completion(.success(value))
				case .failure(let error):
					completion(.failure(error))
				}
			}
	}
}



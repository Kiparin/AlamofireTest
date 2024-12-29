//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Alexey Kiparin on 29.12.2024.
//

import UIKit

final class ViewController: UIViewController {
	
	private let api = NetworkManager.shared
	
	@IBAction func fetchWeather(_ sender: UIButton) {
		switch sender.tag {
		case 1:
			//Ручной педалинг Json
			api.fetchWeatherNow(from: Url.weatherNow.urlString){ [unowned self] result in
				switch result {
				case .success(let weather):
					self.showAlert(title: "Weather",
								   message: "Температура сейчас: \(weather?.current.temperatureNow ?? 0)\(weather?.curentUnits.temperatureType ?? "")\n Долгота: \(weather?.longitude ?? 0)\n Широта: \(weather?.latitude ?? 0) ")
				case .failure(let error):
					self.showAlert(title: "Error", message: error.localizedDescription)
				}
				
			}
			
		default:
			// автоматический объект
			api.fetchWeatherNowAutomatic(from: Url.weatherNow.urlString){ [unowned self] result in
				switch result {
				case .success(let weather):
					self.showAlert(title: "Weather",
								   message: "Температура сейчас: \(weather.current.temperatureNow)\(weather.curentUnits.temperatureType)\n Долгота: \(weather.longitude)\n Широта: \(weather.latitude) ")
				case .failure(let error):
					self.showAlert(title: "Error", message: error.localizedDescription)
				}
			}
		}
	}
	
	private func showAlert(title: String, message: String) {
		DispatchQueue.main.async {
			let alert = UIAlertController(
				title: title,
				message: message,
				preferredStyle: .alert
			)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
}


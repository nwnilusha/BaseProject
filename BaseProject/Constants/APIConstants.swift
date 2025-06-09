//
//  APIConstants.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/5/25.
//

import Foundation

enum APIConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let users = "\(baseURL)/users"
    static let dogsCatsApiKey: String = {
            guard let apiKey = Bundle.main.infoDictionary?["DogsCatsAPIKey"] as? String else {
                fatalError("DOGS_CATS_API_KEY not found in Info.plist. Ensure it's set in build settings.")
            }
            return apiKey
        }()
}


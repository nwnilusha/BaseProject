//
//  ApiService.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 13/11/23.
//

import Foundation

struct ApiService: ApiServicing {
    
    let urlString: String
    
    func getJson<T:Decodable>() async throws ->  T {
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            
            let decorder = JSONDecoder()    
            
            do {
                let decodeData = try decorder.decode(T.self, from: data)
                return decodeData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
}


enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case curruptData
    case decodingError(String)
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The endpoint URL is invalid", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("The APIO failed to issue a valid response", comment: "")
        case .dataTaskError(let string):
            return string
        case .curruptData:
            return NSLocalizedString("The data Provided appears to be currupted", comment: "")
        case .decodingError(let string):
            return string
        }
    }
}

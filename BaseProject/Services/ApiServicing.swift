//
//  ApiServicing.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 10/2/25.
//

import Foundation

protocol ApiServicing {
    
    func getJson<T:Decodable>() async throws ->  T
}

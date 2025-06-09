//
//  Dogs&CatsModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 4/5/25.
//

import Foundation


struct DogsCats: Codable, Hashable {
    let breeds: [Breed]?
    let categories: [Category]?
    let id: String
    let url: String
    let width, height: Int
}

struct Breed: Codable, Hashable {
    let id: String
    let origin: String
    let country_codes: String
}

struct Category: Codable, Hashable {
    let id: Int
    let name: String
}

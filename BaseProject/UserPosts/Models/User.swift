//
//  Users.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 13/11/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

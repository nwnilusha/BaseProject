//
//  Users.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 13/11/23.
//

import Foundation

//https://jsonplaceholder.typicode.com/users
//https://jsonplaceholder.typicode.com/posts

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

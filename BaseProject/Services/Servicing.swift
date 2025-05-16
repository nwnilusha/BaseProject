//
//  Servicing.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 19/11/23.
//

import Foundation

protocol Servicing {
    func getUsers() async throws -> [User]
    func getPosts() async throws -> [Post]
    func getCatsDogs() async throws -> [DogsCats]
}

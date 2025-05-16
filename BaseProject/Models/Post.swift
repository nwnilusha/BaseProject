//
//  Post.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 13/11/23.
//

import Foundation

//Post https://jsonplaceholder.typicode.com/users/1/posts

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

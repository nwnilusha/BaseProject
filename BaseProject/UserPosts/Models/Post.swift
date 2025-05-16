//
//  Post.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 13/11/23.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

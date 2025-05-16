//
//  MockData.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/11/23.
//

import Foundation

extension User {
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    
    static var mockSingleUsers: User {
        self.mockUsers[0]
    }
}

extension Post {
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    
    static var mockSinglePost: Post {
        self.mockPosts[0]
    }
    
    static var mockSingleUserPostArray: [Post] {
        self.mockPosts.filter{ $0.userId == 1}
    }
}

extension DogsCats {
    static var mockDogsCats: [DogsCats] {
        Bundle.main.decode([DogsCats].self, from: "cats.json")
    }
    
    static var mockSingleCat: DogsCats {
        self.mockDogsCats[0]
    }
}

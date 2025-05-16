//
//  MockService.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 17/9/24.
//

import Foundation

class MockService: Servicing {
    
    var mockCatsDogsData: [DogsCats]?
    var shouldThrowError = false
    
    init(mockCatsDogsData: [DogsCats]?) {
        self.mockCatsDogsData = mockCatsDogsData
    }
    
    func getCatsDogs() async throws -> [DogsCats] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return DogsCats.mockDogsCats
    }
    
    func getPosts() async throws -> [Post] {
        return Post.mockPosts
    }
    
    func getUsers() async throws -> [User] {
        return User.mockUsers
    }
    
    
    
}

class MockServiceError: Servicing {
    func getCatsDogs() async throws -> [DogsCats] {
        throw APIError.curruptData
    }
    
    func getPosts() async throws -> [Post] {
        throw APIError.decodingError("Decording Error")
    }
    
    func getUsers() async throws -> [User] {
        throw APIError.curruptData
    }
    
}

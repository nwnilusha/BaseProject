//
//  Service.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 19/11/23.
//

import Foundation

class Service: Servicing {

    private let apiService: ApiServicing
    
    init(apiService: ApiServicing) {
        self.apiService = apiService
    }
    
    func getUsers() async throws -> [User] {
        do {
            let jsonData: [User] = try await apiService.getJson()
            return jsonData
        } catch {
            print("Caught error: \(error)")
            throw error
        }
    }
    
    func getPosts() async throws -> [Post] {
        do {
            let jsonData: [Post] = try await apiService.getJson()
            return jsonData
        } catch {
            print("Caught Error : \(error)")
            throw error
        }
    }
    
    func getCatsDogs() async throws -> [DogsCats] {
        do {
            let jsonData: [DogsCats] = try await apiService.getJson()
            return jsonData
        } catch {
            print("Caught Error : \(error)")
            throw error
        }
    }
}

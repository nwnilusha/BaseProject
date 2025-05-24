//
//  UsersListViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 14/11/23.
//

import Foundation
import SwiftUICore

class UsersListViewModel: ObservableObject {
    private let dataService: Servicing
    private static let usersCache = NSCache<NSString, NSArray>()
    
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    
    init(service: Servicing) {
        self.dataService = service
    }
    
    @MainActor
    func loadData() async {
        
        let cacheKey = "user_list_cache"
        
        if let cachedUsers = Self.usersCache.object(forKey: cacheKey as NSString) as? [User] {
            self.users = cachedUsers
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            if networkMonitor.isConnected {
                let fetchedUsers = try await dataService.getUsers()
                users = fetchedUsers
                Self.usersCache.setObject(fetchedUsers as NSArray, forKey: cacheKey as NSString)
            }
        } catch {
            errorMessage = "Failed to fetch users: \(error.localizedDescription)"
            print(errorMessage ?? "Error observed")
        }
        
    }
}


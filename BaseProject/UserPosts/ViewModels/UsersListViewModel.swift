//
//  UsersListViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 14/11/23.
//

import Foundation

class UsersListViewModel: ObservableObject {
    private let dataService: Servicing
    private var hasLoaded: Bool = false
    private var cachedUsers: [User]?
    
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(service: Servicing) {
        self.dataService = service
    }
    
    @MainActor
    func loadData() async {
        
        if let cachedUsers = cachedUsers, hasLoaded {
            self.users = cachedUsers
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        do {
            let fetchedUsers = try await dataService.getUsers()
            users = fetchedUsers
            cachedUsers = fetchedUsers
            hasLoaded = true
        } catch {
            errorMessage = "Failed to fetch users: \(error.localizedDescription)"
            print(errorMessage ?? "Error observed")
        }
        
    }
}


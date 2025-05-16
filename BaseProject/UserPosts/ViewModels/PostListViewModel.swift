//
//  PostListViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 19/11/23.
//

import Foundation

class PostListViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorDetails: String?
    @Published var posts: [Post] = []
    
    var service: Servicing
    var userId: Int?
    
    private static var postCache: [Int: [Post]] = [:]
    
    init(service: Servicing, userId: Int? = nil) {
        self.service = service
        self.userId = userId
    }
    
    @MainActor
    func getPosts() async {
        
        guard let userId = self.userId else {
            return
        }
        
        if let cachedPosts = Self.postCache[userId] {
            self.posts = cachedPosts
            return
        }
        
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            let fetchedPosts = try await service.getPosts()
            self.posts = fetchedPosts
            Self.postCache[userId] = fetchedPosts
        } catch {
            errorDetails = error.localizedDescription
        }
        
    }
}


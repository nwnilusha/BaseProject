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
    
    private static let postCache = NSCache<NSNumber, NSArray>()
    
    init(service: Servicing, userId: Int? = nil) {
        self.service = service
        self.userId = userId
    }
    
    @MainActor
    func getPosts() async {
        guard let userId = self.userId else { return }
        
        let cacheKey = NSNumber(value: userId)
        
        if let cached = Self.postCache.object(forKey: cacheKey) as? [Post] {
            self.posts = cached
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedPosts = try await service.getPosts()
            self.posts = fetchedPosts
            Self.postCache.setObject(fetchedPosts as NSArray, forKey: cacheKey)
        } catch {
            errorDetails = error.localizedDescription
            print("Failed to fetch posts: \(error.localizedDescription)")
        }
    }
    
    func clearCache() {
        Self.postCache.removeAllObjects()
    }
}



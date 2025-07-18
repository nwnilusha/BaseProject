//
//  Dogs&CatsViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 4/5/25.
//

import Foundation

final class Dogs_CatsViewModel: ObservableObject {
    
    @Published var dogsCats: [DogsCats] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private var pageNumber = 1
    private let imageTypes: String
    private let serviceFactory: (DogsCatsAPIConfig) -> Servicing
    private var hasMoreData: Bool = true
    
    private static let dogsCatsCache = NSCache<NSString, NSArray>()
    
    init(imageTypes: String, serviceFactory: @escaping (DogsCatsAPIConfig) -> Servicing) {
        self.imageTypes = imageTypes
        self.serviceFactory = serviceFactory
    }

    func loadInitialData() async {
        guard dogsCats.isEmpty else { return }
        await loadNextPageIfNeeded()
    }

    @MainActor
    func loadNextPageIfNeeded() async {
        guard hasMoreData else { return }

        let cacheKey = "dogscats_page_\(pageNumber)_type_\(imageTypes)" as NSString
        
        if let cachedAnimals = Self.dogsCatsCache.object(forKey: cacheKey) as? [DogsCats] {
            dogsCats.append(contentsOf: cachedAnimals)
            pageNumber += 1
            return
        }
        
        isLoading = true
        defer { isLoading = false }

        let config = DogsCatsAPIConfig(pageNumber: pageNumber, imageTypes: imageTypes)
        let service = serviceFactory(config)

        do {
            let fetched = try await service.getCatsDogs()
            let filtered = fetched.filter { $0.categories?.first?.name != "hat" }

            if filtered.isEmpty {
                hasMoreData = false
            } else {
                dogsCats.append(contentsOf: filtered)
                Self.dogsCatsCache.setObject(filtered as NSArray, forKey: cacheKey)
                pageNumber += 1
            }
        } catch {
            errorMessage = "Failed to fetch data: \(error.localizedDescription)"
        }
    }
}


struct DogsCatsAPIConfig {
    var pageNumber: Int
    var imageTypes: String

    func urlString() -> String {
        let apiKey = APIConstants.dogsCatsApiKey
        return "https://api.thecatapi.com/v1/images/search?api_key=\(apiKey)&limit=10&page=\(pageNumber)&mime_types=\(imageTypes)&order=random"
    }
}




//
//  ServiceFactory.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 7/5/25.
//

import Foundation

protocol ServiceFactorying {
    func makeService(for urlString: String) -> Servicing
}

final class ServiceFactory: ServiceFactorying {
    func makeService(for urlString: String) -> Servicing {
        let apiService = ApiService(urlString: urlString)
        return Service(apiService: apiService)
    }
}


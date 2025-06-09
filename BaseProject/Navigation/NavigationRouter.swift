//
//  NavigationRouter.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 27/5/25.
//

import Foundation

class NavigationRouter: ObservableObject {
    @Published var path: [Destination] = []

    static let shared = NavigationRouter()

    func reset() {
        path.removeAll()
    }

    func push(_ destination: Destination) {
        path.append(destination)
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}

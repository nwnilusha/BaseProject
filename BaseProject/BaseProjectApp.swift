//
//  BaseProjectApp.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 6/11/23.
//

import SwiftUI

@main
struct BaseProjectApp: App {
    private let serviceFactory = ServiceFactory()

    var body: some Scene {
        WindowGroup {
            HomeView(serviceFactory: serviceFactory)
        }
    }
}

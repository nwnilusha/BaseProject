//
//  Destinations.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 27/5/25.
//

import Foundation

enum Destination: Hashable {
    case home
    case usersList
    case imageSelection
    case bluetoothDevices
    case userPosts(userId: Int)
    case debug
}

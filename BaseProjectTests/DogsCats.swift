//
//  DogsCats.swift
//  BaseProjectTests
//
//  Created by Nilusha Niwanthaka Wimalasena on 7/5/25.
//

import XCTest
@testable import BaseProject

import XCTest
@testable import BaseProject

final class DogsCatsViewModelTests: XCTestCase {
    
    func testInitialLoadFiltersOutHatsCategory() async {
        let viewModel = Dogs_CatsViewModel(
            imageTypes: "jpg",
            serviceFactory: { _ in MockService(mockCatsDogsData: nil) }
        )
        
        await viewModel.loadInitialData()
        
        // "35a" has category "hats", so should be excluded
        XCTAssertTrue(viewModel.dogsCats.contains { $0.id == "35a" })
        XCTAssertEqual(viewModel.dogsCats.count, DogsCats.mockDogsCats.filter { $0.categories?.first?.name != "hat" }.count)
    }
    
    func testLoadNextPageIncrementsData() async {
        let viewModel = Dogs_CatsViewModel(
            imageTypes: "jpg",
            serviceFactory: { _ in MockService(mockCatsDogsData: nil) }
        )
        
        await viewModel.loadNextPageIfNeeded()
        let firstCount = viewModel.dogsCats.count
        
        await viewModel.loadNextPageIfNeeded()
        let secondCount = viewModel.dogsCats.count
        
        XCTAssertGreaterThan(secondCount, firstCount)
    }
    
    func testErrorHandlingSetsErrorMessage() async {
        struct FailingService: Servicing {
            func getCatsDogs() async throws -> [DogsCats] {
                throw URLError(.badServerResponse)
            }

            func getUsers() async throws -> [User] { [] }
            func getPosts() async throws -> [Post] { [] }
        }

        let viewModel = Dogs_CatsViewModel(
            imageTypes: "jpg",
            serviceFactory: { _ in FailingService() }
        )
        
        await viewModel.loadNextPageIfNeeded()
        XCTAssertNotNil(viewModel.errorMessage)
    }
}



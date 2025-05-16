//
//  BaseProjectTests.swift
//  BaseProjectTests
//
//  Created by Nilusha Niwanthaka Wimalasena on 6/11/23.
//

import XCTest
@testable import BaseProject

final class BaseProjectTests: XCTestCase {

    func testGetUsers() async {
        let usersListViewModel = UsersListViewModel(service: MockService(mockCatsDogsData: nil))
        await usersListViewModel.loadData()
        XCTAssertNotNil(usersListViewModel.users)
    }

    func testGetPosts() async {
        let postViewModel = PostListViewModel(service: MockService(mockCatsDogsData: nil))
        await postViewModel.getPosts()
        XCTAssertNotNil(postViewModel.posts)
    }
    
    func testLoadDataError() async {
        let usersListViewModel = UsersListViewModel(service: MockServiceError())
        await usersListViewModel.loadData()
        XCTAssertEqual(usersListViewModel.errorMessage, "Failed to fetch users: \(APIError.curruptData.localizedDescription)")
    }
    
    func testGetPostsErrorNil() async {
        let postViewModel = PostListViewModel(service: MockServiceError())
        await postViewModel.getPosts()
        XCTAssertNil(postViewModel.errorDetails)
    }
    
    func testGetPostsError() async {
        let postViewModel = PostListViewModel(service: MockServiceError(), userId: 1)
        await postViewModel.getPosts()
        XCTAssertEqual(postViewModel.errorDetails, APIError.decodingError("Decording Error").localizedDescription)
    }

}

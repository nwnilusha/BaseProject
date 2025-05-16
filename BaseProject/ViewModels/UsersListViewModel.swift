//
//  UsersListViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 14/11/23.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var users: [User] = []
    var service: Servicing
    
    init(service: Servicing) {
        self.service = service
    }
    
    func fetchUsers() {
        let apiService = ApiService(urlString: "https://jsonplaceholder.typicode.com/users")
        apiService.getJSON { (result: Result<[User], APIError>) in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
         
            case .failure(let error):
                print(error)
            
            }
        }
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
        }
    }
}

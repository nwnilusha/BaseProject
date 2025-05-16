//
//  UsersListView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 6/11/23.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject var viewModel = UsersListViewModel(forPreview: true)
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(viewModel.users) { user in
                    NavigationLink{
                        PostsListView(userId: user.id)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                            Text(user.username)
                                .font(.caption)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .listStyle(.plain)
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}

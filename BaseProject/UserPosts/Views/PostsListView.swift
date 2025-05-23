//
//  PostsListView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 19/11/23.
//

import Foundation
import SwiftUI

struct PostsListView: View {
    
    @StateObject var viewModel: PostListViewModel
    var userId: Int?
    
    init(viewModel: PostListViewModel, userId: Int? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.userId = userId
    }
    
    var body: some View {
        List(viewModel.posts) { posts in
            VStack(alignment: .leading) {
                Text(posts.title)
                    .font(.title)
                Text(posts.body)
                    .font(.caption)
            }
        }
        .navigationTitle("Posts")
        .onAppear {
            if viewModel.posts.isEmpty {
                Task {
                    await viewModel.getPosts()
                }
            }
        }
    }
}

//#Preview {
//    PostsListView(viewModel: PostListViewModel(service: Service(apiService: ApiService(urlString: ""))))
//}

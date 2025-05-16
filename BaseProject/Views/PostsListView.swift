//
//  PostsListView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 19/11/23.
//

import Foundation
import SwiftUI

struct PostsListView: View {
    
    @ObservedObject var viewModel = PostListViewModel(forPreview: false)
    var userId: Int?
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                viewModel.userId = userId
                viewModel.fetchPosts()
            }
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(userId: 1)
        }
    }
}

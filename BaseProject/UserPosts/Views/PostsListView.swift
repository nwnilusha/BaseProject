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
    
    @State private var showErrorAlert = false
    @Environment(\.dismiss) private var dismiss
    
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
        .onChange(of: viewModel.errorDetails) { _, newValue in
            if newValue != nil {
                showErrorAlert = true
            }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(viewModel.errorDetails ?? "")
                .foregroundStyle(.red)
        }
        .navigationTitle("Posts")
        .onAppear {
            if viewModel.posts.isEmpty {
                Task {
                    await viewModel.getPosts()
                }
            }
        }
        .networkAlert()
    }
}

//#Preview {
//    PostsListView(viewModel: PostListViewModel(service: Service(apiService: ApiService(urlString: ""))))
//}

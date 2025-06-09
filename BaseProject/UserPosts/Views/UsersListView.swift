//
//  UsersListView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 6/11/23.
//

import SwiftUI

struct UsersListView: View {
    @StateObject var viewModel: UsersListViewModel
    @EnvironmentObject var router: NavigationRouter
    let serviceFactory: ServiceFactorying
    
    @State private var showErrorAlert = false
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: UsersListViewModel, serviceFactory: ServiceFactorying) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.serviceFactory = serviceFactory
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                Spacer().frame(height: 16)
                ForEach(viewModel.users) { user in
                    NavigationLink(destination: makePostListView(for: user)) {
                        UserView(user: user.name, userName: user.username)
                    }
                }
                Spacer().frame(height: 16)
            }
        }
        .onChange(of: viewModel.errorMessage) { _, newValue in
            if newValue != nil {
                showErrorAlert = true
            }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
                .foregroundStyle(Color.red)
        }
        .navigationTitle("User List")
        .task {
            await viewModel.loadData()
        }
        .networkAlert()
    }
    
    private func makePostListView(for user: User) -> PostsListView {
        let service = serviceFactory.makeService(for: "\(APIConstants.users)/\(user.id)/posts")
        let viewModel = PostListViewModel(service: service, userId: user.id)
        return PostsListView(viewModel: viewModel)
    }
}


struct UserView: View {
    
    let user: String
    let userName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(user)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(userName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

//struct UsersListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsersListView(viewModel: UsersListViewModel(service: Service(apiService: ApiService(urlString: ""))))
//    }
//}

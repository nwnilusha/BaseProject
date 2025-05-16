//
//  HomeView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/5/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Welcome to the Home Screen")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)

                Spacer()

                LazyVGrid(columns: [GridItem(.flexible(), spacing: 24), GridItem(.flexible(), spacing: 24)], spacing: 36) {
                    NavigationLink {
                        let apiService = ApiService(urlString: APIConstants.users)
                        let service = Service(apiService: apiService)
                        let viewModel = UsersListViewModel(service: service)
                        UsersListView(viewModel: viewModel)
                    } label: {
                        ItemView(informationText: "User Data", imageName: "person")
                    }

                    NavigationLink {
                        ImageTypeSelectionView()
                        
                    } label: {
                        ItemView(informationText: "Dogs Cats Data", imageName: "cat")
                    }
                    
                    Button {
                        // Add future action
                    } label: {
                        ItemView(informationText: "Coming Soon", imageName: "globe")
                    }

                    Button {
                        // Add future action
                    } label: {
                        ItemView(informationText: "Coming Soon", imageName: "star")
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct ItemView: View {
    let informationText: String
    let imageName: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundColor(.blue)

            Text(informationText)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 220)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

#Preview {
    HomeView()
}

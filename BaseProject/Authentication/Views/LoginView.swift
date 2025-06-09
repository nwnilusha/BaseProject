//
//  LoginView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 26/5/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @StateObject private var router = NavigationRouter.shared
    
    
    private let serviceFactory = ServiceFactory()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 24) {
                    Text("Welcome To Base Project")
                        .font(.headline)
                        .fontWeight(.bold)

                    Spacer(minLength: 100)
                    
                    Button("Login with Face ID") {
                        DebugLogger.shared.log("Face ID authentication started.")
                        viewModel.authenticate()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    
                if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

            }
            .padding()
//            .onAppear {
//                autoAuthenticateIfNeeded()
//            }
            .onChange(of: viewModel.isLoggedIn) { _, newValue in
                if newValue {
                    router.push(.home)
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .home:
                    HomeView(serviceFactory: self.serviceFactory)
                case .usersList:
                    let service = serviceFactory.makeService(for: APIConstants.users)
                    let viewModel = UsersListViewModel(service: service)
                    UsersListView(viewModel: viewModel, serviceFactory: serviceFactory)
                case .imageSelection:
                    ImageTypeSelectionView()
                case .bluetoothDevices:
                    BluetoothDevicesView()
                case .userPosts(let userId):
                    let service = serviceFactory.makeService(for: "\(APIConstants.users)\(userId)/posts")
                    let viewModel = PostListViewModel(service: service, userId: userId)
                    PostsListView(viewModel: viewModel)
                case .debug:
                    DebugView()
                }
            }
        }
        .environmentObject(router)
        .environmentObject(viewModel)
    }
    
    
}



//#Preview {
//    LoginView()
//}

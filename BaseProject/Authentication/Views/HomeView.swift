//
//  HomeView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/5/25.
//

import SwiftUI

struct HomeView: View {
    
    private let serviceFactory: ServiceFactorying
    
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    init(serviceFactory: ServiceFactorying = ServiceFactory()) {
        self.serviceFactory = serviceFactory
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Home Screen")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            #if DEBUG
                .onLongPressGesture(minimumDuration: 2.0) {
                    router.push(.debug)
                }
            #endif
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 24), GridItem(.flexible(), spacing: 24)], spacing: 36) {
                Button {
                    router.push(.usersList)
                } label: {
                    ItemView(informationText: "User Data", imageName: "person")
                }
                
                Button {
                    router.push(.imageSelection)
                } label: {
                    ItemView(informationText: "Dogs Cats Data", imageName: "cat")
                }
                
                Button {
                    router.push(.bluetoothDevices)
                } label: {
                    ItemView(informationText: "Bluetooth Devices", imageName: "antenna.radiowaves.left.and.right")
                }
                
                Button {
                    // Future action
                } label: {
                    ItemView(informationText: "Coming Soon", imageName: "star")
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    loginViewModel.logout()
                    router.reset()
                }
                .foregroundColor(.red)
            }
        }
        .networkAlert()
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

//#Preview {
//    HomeView()
//}

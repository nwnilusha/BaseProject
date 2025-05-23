//
//  HomeView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 1/5/25.
//

import SwiftUI

struct HomeView: View {
    enum Destination: Hashable {
        case usersList
        case imageSelection
        case bluetoothDevices
    }

    @State private var path: [Destination] = []
    private let serviceFactory: ServiceFactorying

    init(serviceFactory: ServiceFactorying = ServiceFactory()) {
        self.serviceFactory = serviceFactory
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 16) {
                Text("Home Screen")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)

                Spacer()

                LazyVGrid(columns: [GridItem(.flexible(), spacing: 24), GridItem(.flexible(), spacing: 24)], spacing: 36) {
                    Button {
                        path.append(.usersList)
                    } label: {
                        ItemView(informationText: "User Data", imageName: "person")
                    }

                    Button {
                        path.append(.imageSelection)
                    } label: {
                        ItemView(informationText: "Dogs Cats Data", imageName: "cat")
                    }

                    Button {
                        path.append(.bluetoothDevices)
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
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .usersList:
                    let service = serviceFactory.makeService(for: APIConstants.users)
                    let viewModel = UsersListViewModel(service: service)
                    UsersListView(viewModel: viewModel, serviceFactory: serviceFactory)

                case .imageSelection:
                    ImageTypeSelectionView()

                case .bluetoothDevices:
                    BluetoothDevicesView()
                }
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

//#Preview {
//    HomeView()
//}

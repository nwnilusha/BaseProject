//
//  Dogs&CatsListView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 4/5/25.
//

import SwiftUI

struct Dogs_CatsListView: View {

    @StateObject private var viewModel: Dogs_CatsViewModel

    init(imageTypes: String) {
        _viewModel = StateObject(wrappedValue:
            Dogs_CatsViewModel(
                imageTypes: imageTypes,
                serviceFactory: { config in
                    let apiService = ApiService(urlString: config.urlString())
                    return Service(apiService: apiService)
                }
            )
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.dogsCats.indices, id: \.self) { index in
                            let dogCat = viewModel.dogsCats[index]
                            NavigationLink(destination: Dogs_CatsDetailView(dogCatDetails: dogCat)) {
                                DogCatView(dogCat: dogCat)
                            }
                            .buttonStyle(.plain)
                            .onAppear {
                                if index == viewModel.dogsCats.count - 1 {
                                    Task { await viewModel.loadNextPageIfNeeded() }
                                }
                            }
                        }
                    }
                    .padding(.top, 16)
                }

                if viewModel.isLoading && viewModel.dogsCats.isEmpty {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("Dogs & Cats List")
            .task {
                await viewModel.loadInitialData()
            }
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct DogCatView: View {
    let dogCat: DogsCats

    var imageSizeText: String {
        "\(Int(dogCat.height)) x \(Int(dogCat.width))"
    }

    var body: some View {
        HStack(spacing: 16) {
            RemoteImageView(url: URL(string: dogCat.url))
                .frame(width: 100, height: 100)
                .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text("ID: \(dogCat.id)")
                    .font(.headline)
                Text("Image Size: \(imageSizeText)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct RemoteImageView: View {
    let url: URL?

    var body: some View {
        Group {
            if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
    }
}

//#Preview {
//    Dogs_CatsListView()
//}

//
//  Dogs&CatsView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 4/5/25.
//

import SwiftUI

struct Dogs_CatsDetailView: View {
    
    let dogCatDetails: DogsCats
    
    var body: some View {
        VStack(spacing: 20) {
            RemoteImageView(url: URL(string: dogCatDetails.url))
                .frame(width: 300, height: 300)
                .cornerRadius(8)
                .padding()
            VStack(alignment: .leading) {
                Text("Cat ID : \(dogCatDetails.id)")
                Text("Cat Category : \(dogCatDetails.categories?.first?.name ?? "No Category")")
                Text("Image Width : \(dogCatDetails.width)")
                Text("Image Height : \(dogCatDetails.height)")
            }
        }
        .networkAlert()
    }
}

#Preview {
    Dogs_CatsDetailView(dogCatDetails: DogsCats(breeds: nil, categories: nil, id: "1", url: "", width: 100, height: 100))
}

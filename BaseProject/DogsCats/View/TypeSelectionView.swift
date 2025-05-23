//
//  TypeSelectionView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 6/5/25.
//

import SwiftUI

struct ImageTypeSelectionView: View {
    @State private var isGIFSelected = false
    @State private var isPNGJPEGSelected = false
    @State private var navigateNext = false

    var body: some View {
            VStack(alignment: .leading, spacing: 24) {
                Text("Select Image Type")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 16) {
                    Toggle(isOn: $isGIFSelected) {
                        Text("GIF")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxToggleStyle())

                    Toggle(isOn: $isPNGJPEGSelected) {
                        Text("PNG / JPEG")
                            .font(.title2)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                }
                .padding()

                Spacer()

                Button(action: {
                    navigateNext = true
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(isAnySelected ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!isAnySelected)
            }
            .padding()
            .navigationTitle("Image Format")
            .navigationDestination(isPresented: $navigateNext) {
                let selectedImageType = selectedImageTypeString()
                Dogs_CatsListView(imageTypes: selectedImageType)
            }
    }

    var isAnySelected: Bool {
        isGIFSelected || isPNGJPEGSelected
    }

    private func selectedImageTypeString() -> String {
        switch (isGIFSelected, isPNGJPEGSelected) {
        case (true, false): return "gif"
        case (false, true): return "jpg,png"
        case (true, true): return "gif,jpg,png"
        default: return "jpg"
        }
    }
}


struct NextPageView: View {
    var body: some View {
        Text("Next Page")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .imageScale(.large)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}




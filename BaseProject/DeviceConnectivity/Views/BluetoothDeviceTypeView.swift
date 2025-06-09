//
//  BluetoothDeviceTypeView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 20/5/25.
//

import SwiftUI

struct BluetoothDeviceTypeView: View {
    var body: some View {
        ZStack {
           VStack {
                
            }
        }
    }
}

struct DeviceTypeButton: View {
    
    let labelName: String
    
    var body: some View {
        Text(labelName)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

#Preview {
    BluetoothDeviceTypeView()
}

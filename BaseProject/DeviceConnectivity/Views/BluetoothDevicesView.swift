//
//  BluetoothDevicesView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import SwiftUI

struct BluetoothDevicesView: View {
    
    @StateObject var viewModel: BluetoothDevicesViewModel = BluetoothDevicesViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.discoveredPeripherals, id: \.self) { index in
                        NavigationLink(destination: ConnectedDeviceView()) {
                            BluetoothDeviceView(deviceName: "", connectedSttus: "")
                        }
                    }
                }
                Text("Bluetooth Devices")
            }
        }
    }
}

struct BluetoothDeviceView: View {
    
    let deviceName: String
    let connectedSttus: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(deviceName)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(connectedSttus)
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

//#Preview {
//    BluetoothDevicesView()
//}

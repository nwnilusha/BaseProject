//
//  BluetoothDevicesView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import SwiftUI

struct BluetoothDevicesView: View {
    @StateObject private var viewModel = BluetoothDevicesViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.discoveredDevices) { device in
                HStack {
                    Text(device.name)
                    Spacer()
                    Button("Connect") {
                        viewModel.connect(to: device)
                    }
                    .disabled(viewModel.connectionState == .connecting)
                }
            }
            .navigationTitle("Bluetooth Devices")
            .navigationDestination(isPresented: .constant(viewModel.connectionState == .connected)) {
                if let device = viewModel.connectedDevice {
                    ConnectedDeviceView(device: device)
                }
            }
        }
    }
}

//#Preview {
//    BluetoothDevicesView()
//}

//
//  BluetoothDevicesView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import SwiftUI

struct BluetoothDevicesView: View {
    @StateObject private var viewModel = BluetoothDevicesViewModel()
    @StateObject private var audioRouteViewModel = AudioRouteViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 16) {
                ForEach(viewModel.discoveredDevices, id: \.self) { device in
                    BluetoothDeviceView(device: device)
                }
            }
            .padding(.top, 16)
        }
        
        .navigationDestination(isPresented: .constant(viewModel.activeDevice?.deviceState == .connected)) {
            if let _ = viewModel.activeDevice {
                ConnectedDeviceView(deviceVM: viewModel, audioRouteVM: audioRouteViewModel)
            }
        }
        .navigationTitle("Bluetooth Devices")
        .environmentObject(viewModel)
    }
    
}

struct BluetoothDeviceView: View {
    
    @EnvironmentObject var viewModel: BluetoothDevicesViewModel
    let device: BluetoothDevice
    
    var body: some View {
        HStack {
            Text(device.name)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Button(action: {
                viewModel.connect(to: device)
            }) {
                Text(viewModel.activeDevice?.deviceState == .connecting && device.id == viewModel.activeDevice?.id ? "Connecting..." : "Connect")
            }
            .disabled(viewModel.activeDevice?.deviceState == .connecting)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}


//#Preview {
//    BluetoothDevicesView()
//}

//
//  ConnectedDeviceView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import SwiftUI

struct ConnectedDeviceView: View {
    @ObservedObject var deviceVM: BluetoothDevicesViewModel
    @ObservedObject var audioRouteVM: AudioRouteViewModel
    @StateObject private var audioVM = ConnectedDeviceViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Connected to \(deviceVM.activeDevice?.name ?? "Unknown")")
                .font(.title3)
            
            if audioRouteVM.isBluetoothAudioConnected {
                Button("Disconnect") {
                    deviceVM.disconnect()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button(audioVM.isPlaying ? "Pause Song" : "Play Song") {
                    audioVM.togglePlayback()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(audioVM.isPlaying ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Text("No Bluetooth audio device connected.")
                    .foregroundColor(.gray)
                
                Button("Go to Bluetooth Settings") {
                    audioRouteVM.openBluetoothSettings()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Audio Control")
        .navigationBarBackButtonHidden(deviceVM.activeDevice?.deviceState == .connected && audioRouteVM.isBluetoothAudioConnected)
        .onDisappear {
            audioVM.pauseAudio()
        }
        .onChange(of: deviceVM.activeDevice?.deviceState) { _, NewValue in
            if NewValue == .disconnected {
                dismiss() 
            }
        }
        .networkAlert()
    }
}



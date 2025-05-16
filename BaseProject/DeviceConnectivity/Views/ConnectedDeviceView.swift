//
//  ConnectedDeviceView.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import SwiftUI

struct ConnectedDeviceView: View {
    var device: BluetoothDevice
    @StateObject private var audioVM = ConnectedDeviceViewModel()
    @StateObject private var audioRouteVM = AudioRouteViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Connected to \(device.name)")
                .font(.title3)

            if audioRouteVM.isBluetoothAudioConnected {
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
        .onDisappear {
            audioVM.pauseAudio()
        }
    }
}



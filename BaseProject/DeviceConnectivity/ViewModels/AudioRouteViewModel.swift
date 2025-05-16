//
//  AudioRouteViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import AVFoundation
import UIKit

class AudioRouteViewModel: ObservableObject {
    @Published var isBluetoothAudioConnected: Bool = false

    init() {
        observeAudioRoute()
    }

    func observeAudioRoute() {
        let session = AVAudioSession.sharedInstance()
        NotificationCenter.default.addObserver(
            forName: AVAudioSession.routeChangeNotification,
            object: session,
            queue: .main
        ) { [weak self] _ in
            self?.updateRouteStatus()
        }
        updateRouteStatus()
    }

    private func updateRouteStatus() {
        let session = AVAudioSession.sharedInstance()
        let bluetoothOutputs: [AVAudioSession.Port] = [.bluetoothA2DP, .bluetoothHFP, .bluetoothLE]

        isBluetoothAudioConnected = session.currentRoute.outputs.contains { bluetoothOutputs.contains($0.portType) }
    }

    func openBluetoothSettings() {
        if let url = URL(string: "App-Prefs:root=Bluetooth"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


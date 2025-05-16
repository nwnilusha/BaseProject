//
//  ConnectedDeviceViewModel.swift
//  BaseProject
//
//  Created by Nilusha Niwanthaka Wimalasena on 16/5/25.
//

import Foundation
import AVFoundation

class ConnectedDeviceViewModel: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    @Published var isPlaying = false
    
    init() {
        prepareAudio()
    }
    
    private func prepareAudio() {
        guard let url = Bundle.main.url(forResource: "waka-waka", withExtension: "mp3") else {
            print("Audio file not found.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Failed to initialize player: \(error)")
        }
    }
    
    func playAudio() {
        audioPlayer?.play()
        isPlaying = true
    }

    func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
    }

    func togglePlayback() {
        if isPlaying {
            pauseAudio()
        } else {
            playAudio()
        }
    }
}


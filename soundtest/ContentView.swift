//
//  ContentView.swift
//  soundtest
//
//  Created by mop on 9/29/24.
//

import SwiftUI
import AVFoundation

struct SystemSoundPicker: View {
    @State private var selectedSound: SystemSoundID = 1000  // Default sound
    let systemSounds: [String: SystemSoundID] = [
        "New Mail": 1104,
        "Mail Sent": 1001,
        "Voicemail": 1002,
        "Received Message": 1003,
        "Sent Message": 1004,
        "Alarm": 1005,
        "Low Power": 1006,
        "SMS Received 1": 1007,
        "SMS Received 2": 1008
    ]

    var body: some View {
        VStack {
            Picker("Select Sound", selection: $selectedSound) {
                ForEach(systemSounds.keys.sorted(), id: \.self) { soundName in
                    Text(soundName).tag(systemSounds[soundName]!)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .onChange(of: selectedSound) { newSound in
                playSystemSound(newSound)
            }
            .padding()

            Text("Playing sound: \(soundName(for: selectedSound))")
                .font(.headline)
                .padding()
            
            Button("Play All Sounds") {
                listSystemSounds()
            }
        }
    }

    // Function to play the selected system sound
    func playSystemSound(_ soundID: SystemSoundID) {
        AudioServicesPlaySystemSound(soundID)
    }

    // Helper function to get sound name from sound ID
    func soundName(for soundID: SystemSoundID) -> String {
        return systemSounds.first(where: { $0.value == soundID })?.key ?? "Unknown"
    }
    func listSystemSounds() {
        for soundID in 1300...1400 {
            print("Playing sound \(soundID)")
            AudioServicesPlaySystemSound(SystemSoundID(soundID))
            usleep(1000000)  // Sleep for 1 second between sounds
        }
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            SystemSoundPicker()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

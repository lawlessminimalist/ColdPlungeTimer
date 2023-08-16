//
//  SoundListWidget.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 25/6/2023.
//

import SwiftUI
import AVFoundation

struct SoundListWidget: View {
    @Binding var selectedSoundId:Int

    struct Sound: Identifiable {
        let id: Int
        let name: String
    }
    
    // Add your custom sounds here
    let soundList: [Sound] = [
        Sound(id: 1320, name: "Anticipate"),
        Sound(id: 1321, name: "Bloom"),
        Sound(id: 1322, name: "Calypso"),
        Sound(id: 1323, name: "Choo Choo"),
        Sound(id: 1324, name: "Descent"),
        Sound(id: 1325, name: "Fanfare"),
        Sound(id: 1326, name: "Ladder"),
        Sound(id: 1327, name: "Minuet"),
        Sound(id: 1328, name: "News Flash"),
        Sound(id: 1329, name: "Noir"),
        Sound(id: 1330, name: "Sherwood Forest"),
        Sound(id: 1331, name: "Spell")
        //... include other system sound options...
    ]
    
    var body: some View {
        HStack {
            Image(systemName: "music.note")
                .font(.largeTitle)
            Picker(selection: $selectedSoundId, label: Text("Choose Sound")) {
                ForEach(soundList, id: \.id) { sound in
                    Text(sound.name)
                        .tag(sound.id)
                }
            }
            .pickerStyle(.menu)
        }
        .onChange(of: selectedSoundId, perform: { value in
            if let sound = soundList.first(where: { $0.id == value }) {
                // Play the sound when a new one is selected
                playSound(soundID: sound.id)
            }
        })
    }
    
    func playSound(soundID: Int) {
        AudioServicesPlaySystemSound(SystemSoundID(soundID))
    }
}

struct SoundListWidget_Previews: PreviewProvider {
    static var previews: some View {
        SoundListWidget(selectedSoundId: .constant(1320))
    }
}

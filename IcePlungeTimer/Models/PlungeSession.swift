//
//  PlungeSession.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 12/6/2023.
//

import Foundation

class PlungeSession: ObservableObject {
    @Published var minutes: Int
    @Published var seconds: Int
    @Published var temperature: Float

    init(minutes: Int,seconds: Int,temperature: Float) {
        self.minutes = minutes
        self.seconds = seconds
        self.temperature = temperature
    }
    
    //empty initilizer for initilizing state
    init() {
        self.minutes = 0
        self.seconds = 0
        self.temperature = 0.0
    }

}

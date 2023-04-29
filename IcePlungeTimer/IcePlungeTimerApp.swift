//
//  IcePlungeTimerApp.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 23/4/2023.
//

import SwiftUI


@main
struct IcePlungeTimerApp: App {
    @StateObject private var timerModel = TimerModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerModel)
        }
    }
    
}

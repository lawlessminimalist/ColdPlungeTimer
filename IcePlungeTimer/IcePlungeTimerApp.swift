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
    let context = CoreDataStack.shared.persistentContainer.viewContext


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerModel)
                .background(Color(.green)) // Set background color of the app
                .ignoresSafeArea()
                .environment(\.managedObjectContext, context)


        }
    }
    
}

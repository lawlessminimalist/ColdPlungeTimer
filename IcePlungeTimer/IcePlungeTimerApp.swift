//
//  IcePlungeTimerApp.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 23/4/2023.
//

import SwiftUI
import UserNotifications

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
                .onAppear(perform: checkNotificationPermissions)
        }
    }
    
    func checkNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                // Request permission here
                center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                    // Check error or if permission granted
                }
            case .denied:
                // Permission denied
                break
            case .authorized, .provisional, .ephemeral:
                // Permission granted
                break
            @unknown default:
                // Handle future cases
                break
            }
        }
    }
}

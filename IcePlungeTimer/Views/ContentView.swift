//
//  ContentView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 23/4/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var orientation: UIDeviceOrientation = UIDeviceOrientation.portrait

    @State private var selectedTab = 1
    @State private var inNestedView = false
    
    @State private var isCelsius = true
    
    init() {
        UITabBar.appearance().isHidden = inNestedView
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PlungeListView(isCelsius: $isCelsius)
                .tabItem {
                    Image(systemName: "list.bullet")
                }
                .tag(0)
            HomeScreen(inNestedView: $inNestedView,isCelius: $isCelsius)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            
            SettingsView(isCelsius: $isCelsius)
                .tabItem {
                    Image(systemName: "gear")
                }
                .tag(2)
        }
        .toolbar(inNestedView ? .visible : .hidden)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

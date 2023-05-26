//
//  ContentView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 23/4/2023.
//

import SwiftUI

// Place Holder Views
struct ListView: View {
    var body: some View {
        PlungeListView()
    }
}

struct SettingsView: View {
    var body: some View {
        Text("SettingsView")
    }
}


struct ContentView: View {
    
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {

            
            ListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
                .tag(0)
            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
                .tag(2)
        }
    }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

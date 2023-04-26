//
//  ContentView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 23/4/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        IcebergDynamic()
            .frame(width: 300,height: 300)
    }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

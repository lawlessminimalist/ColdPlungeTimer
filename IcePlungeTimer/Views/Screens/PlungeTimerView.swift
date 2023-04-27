//
//  PlungeTimer.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import SwiftUI

struct PlungeTimer: View {
    var body: some View {
        VStack{
            IcebergDynamicView()
            TimerView()
            
        }

    }
}

struct PlungeTimer_Previews: PreviewProvider {
    static var previews: some View {
        PlungeTimer()
    }
}

//
//  TimerView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var vm = TimerModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack{
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium,design: .monospaced))
                .padding()
                .frame(width:width)
            
            Text("Quick Select")
            HStack{
                Button("5 min") {
                    vm.reset(min:5.0)
                    vm.start(minutes: 5.0)
                }
            
                Button("3 min") {
                    vm.reset(min:3.0)
                    vm.start(minutes: 3.0)
                }
                Button("2 min") {
                    vm.reset(min:2.0)
                    vm.start(minutes: 2.0)
                }
                Button("1 min") {
                    vm.reset(min:1.0)
                    vm.start(minutes: 1.0)
                }
            }
        }.onReceive(timer){_ in
            vm.updateCountdown()
        }

    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

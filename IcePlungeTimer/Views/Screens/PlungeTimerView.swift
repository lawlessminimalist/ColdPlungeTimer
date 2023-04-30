//
//  PlungeTimer.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import SwiftUI

struct PlungeTimerView: View {
    @EnvironmentObject var timerModel: TimerModel
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250

    var body: some View {
        VStack{
            IcebergDynamicView()
            TimerView()
        }
        .onAppear(perform:{
            timerModel.start(seconds:timerModel.seconds)
            timerModel.updateCountdown()

        })
        .onReceive(timer){_ in
            timerModel.updateCountdown()
        }

    }
}

struct PlungeTimerView_Previews: PreviewProvider {
    static var timerModel = TimerModel()

    static var previews: some View {
        PlungeTimerView()
            .environmentObject(timerModel)
    }
}

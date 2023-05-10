//
//  PlungeTimer.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//
import Dispatch
import SwiftUI

func normalizeOffset(timerModel: TimerModel) -> Float {
    let baseline = Float(timerModel.initialTime)
    let offsetTime = timerModel.totalSeconds
    let ratio = baseline/offsetTime
    return 120.00/ratio - 60.00
}



struct PlungeTimerView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State var performOnce = false
    @State var waterOffset:CGFloat = CGFloat(0.0)

    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    private let width: Double = 250

    var body: some View {
        VStack{
            IcebergDynamicView(offsetY:$waterOffset)
            TimerView()
        }
        .onAppear(perform:{

                    timerModel.start(seconds:timerModel.seconds)
                    timerModel.updateCountdown()
                    self.waterOffset = CGFloat(timerModel.seconds)
                
            }
        )
        .onDisappear(perform: {
            timerModel.reset()
            timerModel.updateCountdown()

        })
        .onReceive(timer){_ in
            timerModel.updateCountdown()
            print("seconds:\(normalizeOffset(timerModel: timerModel))")
            self.waterOffset = CGFloat(normalizeOffset(timerModel: timerModel) )
            print($waterOffset)
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

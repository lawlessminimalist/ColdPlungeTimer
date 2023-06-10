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
    var offsetTime = Float(max(1, timerModel.totalSeconds))
    let ratio = offsetTime / baseline
    let x = 120 * (1 - ratio)
    print("x=",x)
    return x
}



struct PlungeTimerView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State var performOnce = false
    @State var waterOffset:CGFloat = CGFloat(0.0)
    @Binding var path: [String]
    @State private var showText = false
    @State private var tapCount = 0

    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    private let width: Double = 250

    var body: some View {
        ZStack {

            VStack{
                IcebergDynamicView(offsetY:$waterOffset)
                    Text("Tap twice to exit the plunge")
                        .transition(.opacity)
                        .font(.system(size:20))
                        .foregroundColor(showText ? .black : .gray)
                TimerView()
            }
            .onAppear(perform:{
                timerModel.start(seconds:timerModel.seconds)
                self.waterOffset = 0
                timerModel.updateCountdown() // Updating the countdown as soon as the view appears

                })
            
            .onDisappear(perform: {
                timerModel.reset()
                timerModel.updateCountdown()
            })
            
            .onReceive(timer){_ in
                // Handle timer complete - save and navigate
                if(timerModel.totalSeconds == 0){
                    CoreDataStack.shared.savePlunge(duration: timerModel.initialTime, temperature: 4)
                    path = []
                }
                timerModel.updateCountdown()
                self.waterOffset = CGFloat(normalizeOffset(timerModel: timerModel) )
                print($waterOffset)
            }
            .navigationBarBackButtonHidden(true)
        }
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    tapCount += 1
                    if tapCount == 1 {
                        withAnimation {
                            showText = true
                        }
                        // Reset tapCount and hide text after 3 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showText = false
                            }
                            tapCount = 0
                        }
                    } else if tapCount == 2 {
                        CoreDataStack.shared.savePlunge(
                            duration: Int(Float(timerModel.initialTime) - timerModel.totalSeconds),
                            temperature: 4.00)
                        path = []
                    }
                })
    }

}

struct PlungeTimerView_Previews: PreviewProvider {
    static var timerModel = TimerModel()

    static var previews: some View {
        PlungeTimerView(path: .constant(["Home","Init"]))
            .environmentObject(timerModel)
    }
}

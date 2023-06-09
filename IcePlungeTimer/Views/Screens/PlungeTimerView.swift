//
//  PlungeTimer.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//
import Dispatch
import SwiftUI
import Combine


func normalizeOffset(timerModel: TimerModel) -> Float {
    let baseline = Float(timerModel.initialTime)
    let offsetTime = Float(max(1, timerModel.totalSeconds))
    let ratio = offsetTime / baseline
    return 120 * (1 - ratio)
}

struct PlungeTimerView: View {
    @EnvironmentObject var timerModel: TimerModel
    
    @State var performOnce = false
    @State var waterOffset:CGFloat = CGFloat(0.0)
    @State private var showText = false
    @State private var tapCount = 0
    
    @Binding var path: [String]
    @Binding var inNestedView:Bool
    @Binding var session:PlungeSession

    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State private var timerCancellable: Cancellable? = nil

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
                self.waterOffset = 0
                timerModel.start(seconds:timerModel.seconds)
                timerModel.updateCountdown()
                
                timerCancellable = timer.sink { _ in
                                if(timerModel.totalSeconds == 0 && !performOnce){
                                    session = PlungeSession(minutes: timerModel.minutesElapsed, seconds: timerModel.secondsElapsed, temperature: 4)
                                    path.append("PlungeComplete")
                                    performOnce = true
                                }
                                timerModel.updateCountdown()
                                self.waterOffset = CGFloat(normalizeOffset(timerModel: timerModel))
                            }
                        })
            
            .onDisappear(perform: {
                timerModel.reset()
                timerModel.updateCountdown()
            })
            
            .onReceive(timer){_ in
                timerModel.updateCountdown()
                self.waterOffset = CGFloat(normalizeOffset(timerModel: timerModel) )
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
                        // TODO: add temperature setting
                        session = PlungeSession(minutes: timerModel.minutesElapsed, seconds: timerModel.secondsElapsed, temperature: 4)
                        path.append("PlungeComplete")
                    }
                })
    }

}

struct PlungeTimerView_Previews: PreviewProvider {
    static var timerModel = TimerModel()

    static var previews: some View {
        PlungeTimerView(path: .constant(["Home","Init"]),inNestedView: .constant(true),session: .constant(PlungeSession(minutes: 1, seconds: 2, temperature: 3)))
            .environmentObject(timerModel)
    }
}

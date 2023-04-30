//
//  TimerView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import SwiftUI

struct TimerInitView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State var inTimer = false
    
    private let width: Double = 250
    
    var body: some View {
        NavigationView{
            
            
            VStack{
                Image("iceberg")
                    .resizable()
                    .frame(width: width,height: 250)
                TimerView()
                Slider(value:$timerModel.seconds,in: 0...600, step: 10)
                    .padding()
                    .frame(width: width)
                    .animation(.easeInOut,value: timerModel.seconds)
                
                
                Text("Quick Select")
                HStack{
                    Button("1 min") {
                        timerModel.quickSet(mins: 1.0)
                    }
                    Button("2 min") {
                        timerModel.quickSet(mins: 2.0)
                    }
                    Button("3 min") {
                        timerModel.quickSet(mins: 3.0)
                    }
                    Button("5 min") {
                        timerModel.quickSet(mins: 5.0)
                    }
                }
                NavigationLink(destination: PlungeTimerView().environmentObject(timerModel),isActive: $inTimer, label:{
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue.opacity(0.7))
                        )
                        
                } )
                .onChange(of: inTimer) { isActive in
                    if !isActive {
                        // Reset the state when navigating back
                        timerModel.reset()
                    }

                }
            }
            
        }
    }
}

struct TimerInitView_Previews: PreviewProvider {
    static var timerModel = TimerModel()

    static var previews: some View {

        TimerInitView()
            .environmentObject(timerModel)
    }
}

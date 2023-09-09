//
//  TimerView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import SwiftUI

struct TimerInitView: View {
    @EnvironmentObject var timerModel: TimerModel
    
    @Binding var path: [String]
    @Binding var inNestedView:Bool
    
    @State var inTimer = false
    
    @Binding var selectedSound:Int

    
    private let width: Double = 250
    
    var body: some View {
        VStack{
            Image("iceberg")
                .resizable()
                .frame(width: width,height: 250)
            TimerView()
            Slider(value:$timerModel.seconds,in: 10...600, step: 10)
                .padding()
                .frame(width: width)
                .animation(.easeInOut,value: timerModel.seconds)
            Text("Quick Select")
                .padding(EdgeInsets(top: 0, leading: 0, bottom:0.1, trailing: 0))
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
                }}
            SoundListWidget(selectedSoundId: $selectedSound)
                .padding()
            Button(action: {
                path.append("Plunge")
            }, label: {
                Text("Start")
                    .font(.headline)
                    .padding(.horizontal, 30)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.yellow)
                    )
            } ).padding()}
        
            .onAppear(){

                //Hide the bottom tool bar
                inNestedView = true
            }
            .onDisappear(){
                //Hide the bottom tool bar
                inNestedView = false
            }
    }}

struct TimerInitView_Previews: PreviewProvider {
    static var timerModel = TimerModel()
    
    static var previews: some View {

        TimerInitView(path: .constant(["Home"]),inNestedView: .constant(true),selectedSound: .constant(1320))
            .environmentObject(timerModel)
    }
}

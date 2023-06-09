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
            Button(action: {
                path.append("Plunge")
            }, label: {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue.opacity(0.7))
                    )
            } )}
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

        TimerInitView(path: .constant(["Home"]),inNestedView: .constant(true))
            .environmentObject(timerModel)
    }
}

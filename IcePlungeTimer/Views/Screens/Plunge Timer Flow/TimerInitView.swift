//
//  TimerView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import SwiftUI

struct TimerInitView: View {
    @EnvironmentObject var timerModel: TimerModel
    @State var selectedTemp: Int
    
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
            Slider(value:$timerModel.seconds,in: 5...600, step: 5)
                .padding()
                .frame(width: width)
                .animation(.easeInOut,value: timerModel.seconds)
            HStack{
                ForEach([1.00, 2.00, 3.00, 5.00], id: \.self) { mins in
                    QuickSelectButton(mins: Float(mins),color: Color.blue)
                }
            }
            .padding(.bottom,30)
            Text("Temperature")
            // Add temperature slider to set Ice Bath
            TemperatureSlider(selectedTemp: $selectedTemp)
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

        TimerInitView(selectedTemp: 10,path: .constant(["Home"]),inNestedView: .constant(true))
            .environmentObject(timerModel)
    }
}

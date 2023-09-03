//
//  SwiftUIView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 28/4/2023.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerModel: TimerModel

    var body: some View {
        VStack{
            Text("\(timerModel.time)")
                .font(.system(size: 70, weight: .medium,design: .monospaced))
                .padding()
                .frame(width: 250)
        }
        }

}

struct TimerView_Previews: PreviewProvider {
    static var timerModel = TimerModel()

    static var previews: some View {
        TimerView()
            .environmentObject(timerModel)

    }
}

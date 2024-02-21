//
//  QuickSelect.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 24/10/2023.
//

import SwiftUI

struct QuickSelectButton: View {
    var mins: Float
    var color: Color
    @EnvironmentObject var timerModel: TimerModel

    var body: some View {
        Button("\(Int(mins)) min") {
            timerModel.quickSet(mins: mins)
        }
        .font(.callout)
        .foregroundColor(.white)
        .padding(.horizontal,10)
        .padding(.vertical,5)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
        )
    }
}

struct QuickSelectButtonPreview: PreviewProvider {
    static var timerModel = TimerModel()

    static var previews: some View {
        QuickSelectButton(mins: 1.00,color:Color.blue)
            .environmentObject(timerModel)
    }
}

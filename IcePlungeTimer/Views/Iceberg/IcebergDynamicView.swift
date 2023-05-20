//
//  IcebergDynamic.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 26/4/2023.
//

import SwiftUI




struct IcebergDynamicView: View {
    @Binding var offsetY:CGFloat
    var frameHeight = 300.0

    var body: some View {
        
            Image("iceberg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:300)
                .overlay(
                    CosineWaveLineView(color: Color.blue)
                        .padding()
                        .offset(y: 0-$offsetY.wrappedValue)
                        .animation(Animation.easeInOut(duration: 1), value: $offsetY.wrappedValue)// Use any duration you like

                )
                .background(
                    CosineWaveLineView()
                        .padding()
                        .offset(y: -30-$offsetY.wrappedValue)
                        .animation(Animation.easeInOut(duration: 1), value: $offsetY.wrappedValue) // Use any duration you like

                )
        }
        
}

struct IcebergDynamic_Previews: PreviewProvider {
    static var previews: some View {
        let exampleProgress: CGFloat = 0
        IcebergDynamicView(offsetY: Binding.constant(exampleProgress))
    }
}

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
                    CosineWaveLineView()
                        .padding()
                        .offset(y: 0-$offsetY.wrappedValue)
                )
                .background(
                    CosineWaveLineView()
                        .padding()
                        .offset(y: -30-$offsetY.wrappedValue)
                )
        }
        
}

struct IcebergDynamic_Previews: PreviewProvider {
    static var previews: some View {
        let exampleProgress: CGFloat = 90
        IcebergDynamicView(offsetY: Binding.constant(exampleProgress))
    }
}

//
//  IcebergDynamic.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 26/4/2023.
//

import SwiftUI




struct IcebergDynamicView: View {
    var frameHeight = 300.0

    var body: some View {
        
            Image("iceberg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:300)
                .overlay(
                    CosineWaveLineView()
                        .padding()
                )
                .background(
                    CosineWaveLineView()
                        .padding()
                        .offset(y: -30)

                        
                )
        }
        
}

struct IcebergDynamic_Previews: PreviewProvider {
    static var previews: some View {
        IcebergDynamicView()
    }
}

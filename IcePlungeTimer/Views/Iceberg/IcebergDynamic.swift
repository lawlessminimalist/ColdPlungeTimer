//
//  IcebergDynamic.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 26/4/2023.
//

import SwiftUI




struct IcebergDynamic: View {
    var frameHeight = 300.0

    var body: some View {
        
            Image("iceberg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:300)
                .overlay(
                    CosineWaveLineView()
                        .padding()
                        //.offset(y: ((frameHeight - 100) / 2))
                )
        }
        
}

struct IcebergDynamic_Previews: PreviewProvider {
    static var previews: some View {
        IcebergDynamic()
    }
}

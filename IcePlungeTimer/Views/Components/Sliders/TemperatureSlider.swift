//
//  TemperatureSlider.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 29/10/2023.
//

import SwiftUI

struct Selection {
    let id:UUID;
    let value:Int
}

struct TemperatureSlider: View {
    @Binding var selectedTemp: Int
    let selections: [Selection] = (-20..<60).map { Selection(id: UUID(), value: $0) }


    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 2) {
                ForEach(selections, id: \.id) { item in
                    Button(action: {
                        selectedTemp = item.value
                        print("\(selectedTemp)")
                    }) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 30, height: 40)
                            .foregroundColor(item.value == selectedTemp ? Color.blue : Color.gray)
                            .opacity(item.value == selectedTemp ? 1.0: 0.3)
                            .overlay(content: {
                                Text("\(item.value)")
                                    .font(.subheadline)
                                    .foregroundColor(item.value == selectedTemp ? Color.white: Color.black)
                            })
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .frame(width: 128)
    }
}


struct TemperatureSlider_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureSlider(selectedTemp: .constant(19))
    }
}

//
//  SettingsView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 9/9/2023.
//

import SwiftUI

struct TemperatureToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.headline)
                .padding(.trailing, 10)

            Spacer()

            Capsule()
                .frame(width: 80, height: 30)
                .foregroundColor(configuration.isOn ? Color.blue : Color.gray)
                .overlay(
                    Button(action: {
                        configuration.isOn.toggle()
                    }) {
                        Text(configuration.isOn ? "˚C" : "˚F")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 30)
                            .background(Capsule().fill(Color.white.opacity(0.8)))
                    }
                    .offset(x: configuration.isOn ? 20 : -20)
                    .animation(.linear, value: configuration.isOn)
                )
        }
    }
}

struct SettingsView: View {
    @Binding var isCelsius:Bool
    
    var body: some View {
        List{
            Toggle("Temperature Unit", isOn: $isCelsius)
                .toggleStyle(TemperatureToggleStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isCelsius:.constant(true))
    }
}

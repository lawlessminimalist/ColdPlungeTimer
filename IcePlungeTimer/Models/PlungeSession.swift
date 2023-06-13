//
//  PlungeSession.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 12/6/2023.
//

import Foundation

class PlungeSession: ObservableObject {
    @Published var minutes: Int
    @Published var seconds: Int
    @Published var temperature: Float
    @Published var kcaloricBurn:Int


    init(minutes: Int,seconds: Int,temperature: Float) {
        self.minutes = minutes
        self.seconds = seconds
        self.temperature = temperature
        self.kcaloricBurn = PlungeSession.calculateCaloricBurn(
            tempCelsius:temperature,
            minutes: minutes,
            seconds: seconds
        )
    }
    
    //empty initilizer for initilizing state
    init() {
        self.minutes = 0
        self.seconds = 0
        self.temperature = 0.0
        self.kcaloricBurn = 0
    }
    
    /**
    Function to calculate the estimated number of calories burned during a cold bath.

    Parameters:
     - tempCelsius: The temperature of the bath water in degrees Celsius as a Float.
     - minutes: The duration of the bath in minutes as an Int.
     - seconds: Additional duration of the bath in seconds as an Int.

    Assumptions:
     - Body surface area: 2 m²
     - Rate of heat loss: 50 W/m²°C
     - Body temperature: 37°C

    Note: This function provides a rough estimation. Actual caloric burn may vary.

    Returns: The estimated number of calories burned, rounded down to the nearest whole number, as an Int.
    */
    static func calculateCaloricBurn(tempCelsius: Float, minutes: Int, seconds: Int) -> Int {
        let bodyTemp: Float = 37.0
        let surfaceArea: Float = 2.0
        let heatLossPerM2PerC: Float = 50.0

        // Calculate the temperature difference
        let deltaTemp = bodyTemp - tempCelsius

        // Calculate the heat loss in watts
        let heatLoss = surfaceArea * heatLossPerM2PerC * deltaTemp

        // Calculate the total duration in seconds
        let totalSeconds = Float(minutes * 60 + seconds)

        // Calculate the total energy loss in joules
        let energyLossJ = heatLoss * totalSeconds

        // Convert joules to kilocalories
        let energyLossKcal = energyLossJ / 4184.0

        // Round down to the nearest whole number and return as an Int
        return Int(floor(energyLossKcal))
    }


}

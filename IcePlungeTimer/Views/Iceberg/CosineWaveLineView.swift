//
//  CosineWave.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 27/4/2023.
//

import SwiftUI

struct CosineWaveLine: Shape {
    var phase: CGFloat
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let amplitude = rect.height * 0.05
        let frequency = 1 * CGFloat.pi / rect.width
        
        var path = Path()
        
        for x in stride(from: CGFloat(0), through: rect.width, by: 1) {
            let y = rect.midY + amplitude * cos(frequency * x + phase)
            
            if x == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}


struct CosineWaveLineView: View {
    @State private var phase: CGFloat = 0.1
    public var color:Color = Color.blue
    
    var body: some View {

    CosineWaveLine(phase: phase)
        .stroke(color, lineWidth: 10)
        .animation(.linear(duration: 2.1).repeatForever(autoreverses: false), value: phase)
        .onAppear {
            withAnimation {
                phase = 2 * CGFloat.pi
            }
        }

    }
}

struct CosineWaveLine_Previews: PreviewProvider {
    
    static var previews: some View {
        CosineWaveLineView()
    }
}

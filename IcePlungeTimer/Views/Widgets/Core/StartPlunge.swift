//
//  StartPlunge.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 3/9/2023.
//

import SwiftUI

struct StartPlunge: Widget {
    var id = UUID()
    var name: String = "StartPlunge"

    func makeView() -> AnyView {
        AnyView(StartPlungeView(path: .constant([])))
    }
}

struct StartPlungeView: View {
    @State private var phase: CGFloat = 0.1
    @Binding public var path: [String]

    var body: some View {
        VStack {
            Image("iceberg")
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.cyan, lineWidth: 10))
                .frame(width: 150, height: 150)
                .overlay(
                    CosineWaveLine(phase: phase)
                        .stroke(.blue, lineWidth: 10)
                        .animation(.linear(duration: 2.1).repeatForever(autoreverses: false), value: phase)
                        .onAppear {
                            withAnimation {
                                phase = 2 * CGFloat.pi
                            }
                        }
                        .padding()
                )
            Button(action: {
                path.append("Init")
            }, label: {
                Text("Start Plunge")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(50)
                    .padding()
                    .scaledToFill()
            })
        }
    }
}


struct StartPlunge_Previews: PreviewProvider {
    static var previews: some View {
        StartPlungeView(path: .constant([]))
    }
}

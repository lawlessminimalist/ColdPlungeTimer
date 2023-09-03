//
//  Protocols.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 3/9/2023.
//

import Foundation
import SwiftUI


protocol Widget: Identifiable {
    var id: UUID { get }
    var name: String { get }
    func makeView() -> AnyView
}


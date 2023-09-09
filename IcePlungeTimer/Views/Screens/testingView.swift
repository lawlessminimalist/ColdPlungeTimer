//
//  testingView.swift
//  IcePlungeTimer
//
//  Created by Daniel Lawless on 3/9/2023.
//

import SwiftUI
import Foundation

struct DraggableWidget: Identifiable, Equatable {
    let id: UUID = UUID()
    var name: String
}


struct ProgressBarWidget: View {
    var progress: Double
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                .frame(width: 100, height: 10)
                .padding(.bottom, 5)
            
            Text("\(Int(progress))%")
                .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

import SwiftUI

struct DraggableGridView: View {
    @State private var widgets: [DraggableWidget] = (1...9).map { _ in DraggableWidget(name: "test") }
    
    @State private var currentlyDragging: DraggableWidget?

    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
        
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(widgets) { item in
                ProgressBarWidget(progress: Double.random(in: 0...100))
                    .onDrag {
                        self.currentlyDragging = item
                        return NSItemProvider(object: "\(item.id.uuidString)" as NSString)
                    }
                    .onDrop(of: ["public.text"], delegate: DragRelay(item: item, widgets: $widgets, currentlyDragging: $currentlyDragging))
            }
        }
        .padding()
        
    }
}

struct DragRelay: DropDelegate {
    let item: DraggableWidget
    @Binding var widgets: [DraggableWidget]
    @Binding var currentlyDragging: DraggableWidget?

    func performDrop(info: DropInfo) -> Bool {
        if let dragged = currentlyDragging {
            swapItems(draggedItem: dragged, targetItem: item)
            currentlyDragging = nil
            return true
        }
        return false
    }
    
    private func swapItems(draggedItem: DraggableWidget, targetItem: DraggableWidget) {
        if let sourceIndex = widgets.firstIndex(of: draggedItem), let targetIndex = widgets.firstIndex(of: targetItem) {
            widgets.swapAt(sourceIndex, targetIndex)
        }
    }
}



struct testingView: View {
    var body: some View {
    DraggableGridView()  // Use the grid system
    // Your navigation destinations...
        
    }
}

struct testingView_Previews: PreviewProvider {
    static var previews: some View {
        testingView()
    }
}

//
//  PencilKitView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//  SwiftUI Pencil Kit - SwiftUI Drawing App Using Pencil Kit - Xcode 12 - iOS SwiftUI 2.0 Tutorials
//  https://youtu.be/LR-ttBoa89M

import SwiftUI
import PencilKit

struct PencilKitView: UIViewRepresentable {
    
    typealias UIViewType = PKCanvasView
    
//    let canvas: PKCanvasView
    let toolPicker = PKToolPicker()
    
    // capture drawing for saving into albums
//    @Binding var canvasSaveToAlbum: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        let pencilKitCanvasView = PKCanvasView()
        pencilKitCanvasView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        
        toolPicker.addObserver(pencilKitCanvasView)
        toolPicker.setVisible(true, forFirstResponder: pencilKitCanvasView)
        
        pencilKitCanvasView.becomeFirstResponder()
        
        return pencilKitCanvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
}

struct PencilKitView_Previews: PreviewProvider {
    static var previews: some View {
        PencilKitView()
    }
}

//
//  CanvasNewView.swift
//  UndoPencilKit
//
//  Created by Frank Chu on 4/21/22.
//

import SwiftUI
import PencilKit

struct CanvasNewView: View {
    @State private var canvasView = PKCanvasView()
    @State private var toolPickerIsActive = false
    @State var canvasIsVisible = true
    @State var saveSuccessfullyAlert = false
    var shuffleButton: () -> Void = {}

    var body: some View {
        
        VStack {
            if canvasIsVisible {
                CanvasView(canvasView: $canvasView,
                              toolPickerIsActive: $toolPickerIsActive,
                              onChange: canvasDidChange)
                    .onAppear { toolPickerIsActive = true }
                    .onDisappear { toolPickerIsActive = false }
            } else {
                Button {
                    canvasIsVisible.toggle()
                } label: {
                    Text("Start Drawing")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding()
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    canvasIsVisible.toggle()
                    canvasIsVisible.toggle()
                    canvasIsVisible.toggle()
                }, label: {
                    Image(systemName: canvasIsVisible ? "pencil.circle.fill" : "pencil.circle")
                })
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button() {
                    self.shuffleButton()
                } label: {
                    VStack {
                        Image(systemName: "shuffle")
//                            .font(.largeTitle)
//                            .padding(.bottom, 4)
//                        Text("Shuffle Flag")
                    }
                }
//                .buttonStyle(.bordered)
//                .controlSize(.large)
//                .padding(.horizontal)
            }
            
            ToolbarItem {
                Button {
                    let imageSaver = ImageSaver()
//                    imageSaver.writeToPhotoAlbum(image: canvasView.drawing.image(from: canvasView.bounds, scale: 10).withBackground(color: .black))
                    imageSaver.writeToPhotoAlbum(image: canvasView.drawing.image(from: canvasView.bounds, scale: 10, userInterfaceStyle: .dark).withBackground(color: .black))
                    saveSuccessfullyAlert.toggle()
//                    canvasIsVisible.toggle()
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }
            }
            
            ToolbarItem {
                Button("Clear") {
                    canvasView.drawing = PKDrawing()
                    canvasIsVisible.toggle()
                    canvasIsVisible.toggle()
                }
                
            }
        }
        .navigationViewStyle(.stack)
        .navigationTitle("Let's Draw")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            canvasIsVisible.toggle()
        }
        .alert("Saved Successfully", isPresented: $saveSuccessfullyAlert) {}
        .preferredColorScheme(.light)
    }
    

        private func canvasDidChange() {
        // Do something with updated canvas.
    }
}

struct CanvasNewView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasNewView()
    }
}

struct CanvasView: UIViewRepresentable {

    class Coordinator: NSObject, PKCanvasViewDelegate {
        var canvasView: Binding<PKCanvasView>
        let onChange: () -> Void
        private let toolPicker: PKToolPicker

        deinit {       // << here !!
            toolPicker.setVisible(false, forFirstResponder: canvasView.wrappedValue)
            toolPicker.removeObserver(canvasView.wrappedValue)
        }

        init(canvasView: Binding<PKCanvasView>, toolPicker: PKToolPicker, onChange: @escaping () -> Void) {
            self.canvasView = canvasView
            self.onChange = onChange
            self.toolPicker = toolPicker
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            if canvasView.drawing.bounds.isEmpty == false {
                onChange()
            }
        }
    }

    @Binding var canvasView: PKCanvasView
    @Binding var toolPickerIsActive: Bool
    private let toolPicker = PKToolPicker()
    
    let onChange: () -> Void

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = true
        canvasView.delegate = context.coordinator
        showToolPicker()

        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        toolPicker.setVisible(toolPickerIsActive, forFirstResponder: uiView)
    }

    func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: $canvasView, toolPicker: toolPicker, onChange: onChange)
    }
}

extension UIImage {
  func withBackground(color: UIColor, opaque: Bool = true) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        
    guard let ctx = UIGraphicsGetCurrentContext(), let image = cgImage else { return self }
    defer { UIGraphicsEndImageContext() }
        
    let rect = CGRect(origin: .zero, size: size)
    ctx.setFillColor(color.cgColor)
    ctx.fill(rect)
    ctx.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
    ctx.draw(image, in: rect)
        
    return UIGraphicsGetImageFromCurrentImageContext() ?? self
  }
}

extension PKDrawing {
  
  func image(from rect: CGRect, scale: CGFloat, userInterfaceStyle: UIUserInterfaceStyle) -> UIImage {
    let currentTraits = UITraitCollection.current
    UITraitCollection.current = UITraitCollection(userInterfaceStyle: userInterfaceStyle)
    let image = self.image(from: rect, scale: scale)
    UITraitCollection.current = currentTraits
    return image
  }
}

//
//  DrawingFlag.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//  [#SwiftUI] PencilKit Tutorial
//  https://www.youtube.com/watch?v=StyJPF4Uv4k

//  Flag Emoji from Region Code

// A simple Swift function to return a flag emoji from an ISO 3166-1 region code. For more details, see my blog post at https://bendodson.com/weblog/2016/04/26/emoji-flags-from-iso-3166-country-codes-in-swift/






import SwiftUI
import PencilKit
import CoreData


struct DrawingFlag: View {
    @FetchRequest(sortDescriptors: []) var flagsDrawingFlag: FetchedResults<FlagEntities>
    @Environment(\.managedObjectContext) var mocDrawingFlag
    @State var buttonPressed = false
    
//    @State var flagsTemp = String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
//    @State var shuffleButtonIsPressed = false
    
    
    @State var randomFlag = ""
    var body: some View {
        NavigationView {
                VStack {
                    Text("Let's Draw")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    Text(randomFlag)
                        .font(.system(size: 160))
                    if randomFlag != "" {
                        Text(flagToName(flag: randomFlag))
                            .font(.largeTitle).bold()
                    }
//
//                    Text(randomFlag.nameFlag ?? "")
//                        .font(.title)
//
//                    Text(randomFlag.shortIntro ?? "")
//                        .font(.caption2)
                    
                    
                    Spacer()
                    Button() {
                        changePicture()
                        buttonPressed = true
                        
//                        randomFlag = flagsDrawingFlag.randomElement()
//                    flagsTemp = String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
                    } label: {
                        VStack {
                            Image(systemName: "shuffle")
                                .font(.largeTitle)
                                .padding(.bottom, 4)
                            Text("Shuffle Flag")
                            
                            
                        }
                        .frame(maxWidth: 180, maxHeight: 100)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding()
                    
                    
                }//: end of VStask
                .padding()
                .onAppear() {
                    randomFlag = flagsDrawingFlag.randomElement()?.emojiFlag ?? ""
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.darkBackground)
//            VStack {
            CanvasNewView(canvasIsVisible: !buttonPressed)
//            }
            
//            .background(.darkBackground)
//            .navigationTitle("Draw anything here, just be more creative")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                Button() {
//
//                } label: {
//                    Image(systemName: "square.and.arrow.down")
//                }
//            }
        } //: Navigation View End
        
        
    }
    
    
    func changePicture() {
        var tempFlag = randomFlag
        while tempFlag == randomFlag && flagsDrawingFlag.count > 1 {
            tempFlag = flagsDrawingFlag.randomElement()?.emojiFlag ?? ""
        }
        randomFlag = tempFlag
    }
    
    func saveImage() {
//        let image =
    }
    
}

//struct DrawingFlag_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawingFlag()
//    }
//}

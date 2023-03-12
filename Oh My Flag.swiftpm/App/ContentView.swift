//
//  ContentView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI
//#-learning-task(Gallery)
//#-learning-task(Quiz)
//#-learning-task(Drawing)
struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var flagsInContentView: FetchedResults<FlagEntities>
    @Environment(\.managedObjectContext) var mocInContentView
    
    @State private var showWhatsNew = false
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            /*#-code-walkthrough(1.1)*/
            FlagGallery(showWhatsNew: $showWhatsNew)
                .tabItem {
                    Label("Gallery", systemImage: "house")
                }
            /*#-code-walkthrough(1.1)*/
            /*#-code-walkthrough(2.1)*/
            QuizFlag()
                .tabItem {
                    Label("Quiz", systemImage: "lightbulb")
                }
            /*#-code-walkthrough(2.1)*/
            /*#-code-walkthrough(3.1)*/
            DrawingFlag()
                .tabItem {
                    Label("Drawing", systemImage: "scribble")
                }
            /*#-code-walkthrough(3.1)*/
        }
        .sheet(isPresented: $showWhatsNew) {
            NewVerWhatsNew()
        }
        .onAppear() {
            showWhatsNew = checkForUpdate()
            if showWhatsNew {
                addTemplateFlag()
            }
        }
        
    // MARK: -
        
//        .onAppear {
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
//            AppDelegate.orientationLock = .landscape // And making sure it stays that way
//        }.onDisappear {
//            AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
//        }
    }
    func addTemplateFlag() {
        let newFlag = FlagEntities(context: mocInContentView)
        newFlag.id = UUID()
        newFlag.emojiFlag = "🇨🇭"
        newFlag.nameFlag = "Switzerland"
        newFlag.shortIntro = "White Across in a Red Square"
        newFlag.detailedIntro = "Mar 12, 2020\nIn the history class, we learned about Switzerland. The history of this area is fascinating.\n\nDec 8, 2020: \nA year ago, I went to Switzerland. I hope that pandemic will end soon. I want to travel again!😭\n\nDec 9, 2019: Grindelwald First \nIt's the best time of my trip. Cable car🚠, glider, cliff🏔! \n\nDec 8, 2019: Zurich, a beautiful city in the Switzerland \n🌁 Panorama bridge Sigriswil, what a sophisticated bridge. I love the structure of this bridge!"

        try? mocInContentView.save()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func emojiFlag(regionCode: String) -> String? {
    let code = regionCode.uppercased()

    guard Locale.isoRegionCodes.contains(code) else {
        return nil
    }

    var flagString = ""
    for s in code.unicodeScalars {
        guard let scalar = UnicodeScalar(127397 + s.value) else {
            continue
        }
        flagString.append(String(scalar))
    }
    return flagString
}

func countryName(from countryCode: String) -> String {
    if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
        // Country name was found
        return name
    } else {
        // Country name cannot be found
        return countryCode
    }
}

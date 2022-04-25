//
//  RandomNewFlag.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI
import UIKit
import CoreData

struct RandomNewFlag: View {
//    @FetchRequest(sortDescriptors: []) var fagEntitiesRandomNewFlags: FetchedResults<FlagEntities>
    
    @Environment(\.managedObjectContext) var mocRandomNewFlag
    
    @State var flagCode = ""
    @State var tempflag = ""
    @State private var name = ""
    @State private var short = ""
    @State private var detailed = "Woah! You are so fast. Tap button at top right coner to edit your content."
    
    var body: some View {
        
        VStack{
            
            Button() {
                flagCode = Locale.isoRegionCodes.randomElement()!
                tempflag = emojiFlag(regionCode: flagCode) ?? "🏳️‍🌈"
                let newFlag = FlagEntities(context: mocRandomNewFlag)
                newFlag.id = UUID()
                newFlag.emojiFlag = tempflag
                newFlag.nameFlag = countryName(from: flagCode)
                newFlag.shortIntro = flagCode
                newFlag.detailedIntro = detailed
                
                try? mocRandomNewFlag.save()
                
            } label: {
                HStack {
                    Image(systemName: "shuffle")
                        .font(.title)
                        .padding(.bottom, 4)
                    Text("Random Add")
                }
                .frame(maxWidth: 180, maxHeight: .infinity)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
//        .frame(maxWidth: .infinity)
    }
    
    

    
    
}

struct RandomNewFlag_Previews: PreviewProvider {
    static var previews: some View {
        RandomNewFlag()
    }
}

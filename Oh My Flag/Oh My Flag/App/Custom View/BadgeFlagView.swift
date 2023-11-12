//
//  BadgeFlagView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI
import CoreData

struct BadgeFlagView: View {
//    @FetchRequest(sortDescriptors: []) var flagsBadgeView: FetchedResults<FlagEntities>
//    @Environment(\.managedObjectContext) var mocInBadgeFlagView
    let flag: FlagEntities
    var body: some View {
        
        VStack {
            Text(flag.emojiFlag)
                .frame(height: 96)
                .font(.system(size: 96))
                .padding()

            VStack {
                Text(flag.nameFlag)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(flag.shortIntro)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(.lightBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
    
}

//struct BadgeFlagView_Previews: PreviewProvider {
//    static var previews: some View {
//        BadgeFlagView()
//    }
//}

//
//  IntroView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/11/22.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
//        (alignment: .leading)
        GeometryReader { geometry in
            
            VStack {
                Spacer()
                Text("Crate with \"\(Image(systemName: "plus"))\" or \"\(Image(systemName: "shuffle"))\" \n\nEnjoy in Landscape š„³")
                    .font(.largeTitle)
                Spacer()
//                Text("Go to Quiz to Review your Gallery Flag \nš Add 3 Flags Before Going to Quiz\n\n")
//                Text("Go to āļø Drawing to Extend your Painting Skills")
//                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
            .preferredColorScheme(.dark)
        }
        .background(.darkBackground)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

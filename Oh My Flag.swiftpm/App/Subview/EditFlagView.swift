//
//  EditFlagView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/11/22.
//

import SwiftUI
import CoreData

struct EditFlagView: View {
    @Environment(\.managedObjectContext) var mocInEditFlagView
    var flag: FlagEntities
    
    @State private var emoji = ""
    @State private var name = ""
    @State private var short = ""
    @State private var detailed = ""
    
    @State private var alertInNil = false
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Spacer()
                    VStack {
                    Text(emoji == "" ? "🏴‍☠️" : emoji)
                        .font(.system(size: 120))
                        .frame(height: 160)
                    Text(emoji != "" ? flagToName(flag: emoji) : "Pirate Flag")
                        .font(.largeTitle).bold()
                    }
                    Spacer()
                }
//                Form {
                    Section {
                        EmojiTextField(text: $emoji, placeholder: "* Flag (Emoji, please! 🏴‍☠️)")
                            .onReceive(emoji.publisher.collect()) {
                                self.emoji = String($0.prefix(1))
                            }
                        TextField("* Name of the Flag (Decided by Yourself)", text: $name)
                        TextField("* Describe the Flag in One Line", text: $short)
                    }
                    Section {
                        TextEditor(text: $detailed)
                            .frame(height: 300)
                    } header: {
                        Text("Write Some \"Stories\" Here 🤪 (optional)")
                    }
//                }
                
                
                }
            .navigationTitle("Edit the Flag 🏁")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if emoji == "" || name == "" || short == "" {
                            alertInNil = true
                        } else {
                            alertInNil = false
                            flag.id = UUID()
                            flag.emojiFlag = emoji
                            flag.nameFlag = name
                            flag.shortIntro = short
                            flag.detailedIntro = detailed
                            try? mocInEditFlagView.save()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
                .onAppear() {
                    emoji = flag.emojiFlag
                    name = flag.nameFlag
                    short = flag.shortIntro
                    detailed = flag.detailedIntro
                
            } //: End of VStack
                .alert("The text field is empty", isPresented: $alertInNil) {}
        } //: End of Navigation View
        
    }
    
}

//struct EditFlagView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditFlagView()
//    }
//}


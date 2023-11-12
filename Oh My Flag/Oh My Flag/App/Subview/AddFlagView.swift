//
//  AddFlagView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct AddFlagView: View {
    @Environment(\.managedObjectContext) var mocInAddFlagView
    
    
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
//                    Section {}
                    Section {
                        EmojiTextField(text: $emoji, placeholder: "* Flag (Emoji, please! 🏴‍☠️)")
                            .onReceive(emoji.publisher.collect()) {
                                self.emoji = String($0.prefix(1))
                            }
                        TextField("* Name of the Flag (Decided by Yourself)", text: $name)
                        TextField("* Describe the Flag in One Line", text: $short)
                    } header: {
//                        if emoji != "" {
//                            Text("Wow, the flag name is \(flagToName(flag: emoji))")
//                        } else {
//                            Text("")
//                        }
                    }
                    Section {
                        TextEditor(text: $detailed)
                            .frame(height: 300)
                    } header: {
                        Text("Write Some \"Stories\" Here 🤪 (optional)")
                    }
//                }
                
            } //: End of VStack
            .navigationTitle("Add New Flag 🏁")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if emoji == "" || name == "" || short == "" {
                            alertInNil = true
                        } else {
                            alertInNil = false
                            let newFlag = FlagEntities(context: mocInAddFlagView)
                            newFlag.id = UUID()
                            newFlag.emojiFlag = emoji
                            newFlag.nameFlag = name
                            newFlag.shortIntro = short
                            newFlag.detailedIntro = detailed
                            
                            try? mocInAddFlagView.save()
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
            .alert(isPresented: $alertInNil) {
                Alert(title: Text("The Field is empty"))
            }
            
        } //: End of Navigation View
        
        
    } //: End of body View
    func convertToCountryCode(emoji: Character) -> String {
        for scalar in emoji.unicodeScalars {
            return scalar.properties.name ?? "US"
        }
        return "US"
    }
}

struct AddFlagView_Previews: PreviewProvider {
    static var previews: some View {
        AddFlagView()
            .previewInterfaceOrientation(.landscapeRight)
        
    }
}

public extension String {
    func indexInt(of char: Character) -> Int? {
        return firstIndex(of: char)?.utf16Offset(in: self)
    }
}
func flagToName(flag: String) -> String{
    let c : Character = flag.first!
    let cfstr = NSMutableString(string: String(c)) as CFMutableString
    var range = CFRangeMake(0, CFStringGetLength(cfstr))
    CFStringTransform(cfstr, &range, kCFStringTransformToUnicodeName, false)
//    print(cfstr)
    let outputs = String(cfstr)
//    print(outputs)
    var i = 0
    var countryCode = ""
    for output in outputs {
        
        if i == 36 || i == 74 {
            countryCode += String(output)
        }
        i += 1
    }
    var fullName = ""
    if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
        // Country name was found
        fullName = name
    } else {
        // Country name cannot be found
        fullName = countryCode
    }
    return fullName
}

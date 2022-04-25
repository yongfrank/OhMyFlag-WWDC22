//
//  WhatsNewView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/15/22.
//

import SwiftUI

struct WhatsNewView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            
            GeometryReader { geometry in
                ScrollView {
                    HStack {
                        VStack {
                            VStack(alignment: .leading) {
                                
                                Group {
                                    Text("\nHi, welcome to Oh My Flag 🥳. It's an app that helps you collect flags in your daily life. \n\nFeel free to tap done at the top right corner if you want to explore by yourself or you've known how to use the App. \n\nWant to know the details of the Oh My Flag App? Let me show you!")
                                    
                                    HStack(alignment: .bottom) {
                                        Image(systemName: "house")
                                        Text("Gallery Tab")
                                    }
                                    .font(.title)
                                    .padding(.vertical)
                                    Text("This is the first tab called gallery. As the name suggests it's a place to exhibit your beloved flags.")
                                        .padding(.horizontal)
                                    
                                    
                                    HStack() {
                                        Spacer()
                                        VStack {
                                            Button {
                                            } label: {
                                                HStack {
                                                    Image(systemName: "shuffle")
                                                        .font(.largeTitle)
                                                        .padding(.bottom, 4)
                                                    Text("Random Add")
                                                }

                                            }
                                            .frame(maxWidth: 200)
                                            Text("💨 Add a flag to your gallery randomly")
                                                .padding(.top)
                                        }
                                        
                                        Spacer()
                                    }
                                    .buttonStyle(.bordered)
                                    .controlSize(.large)
                                    .padding(.vertical)
                                    
                                    
                                    HStack() {
                                        Spacer()
                                        VStack {
                                            Button {
                                            } label: {
                                                Image(systemName: "plus")
                                                    .font(.largeTitle)
                                                    .padding(.bottom, 4)
                                                Text("Add New Flag")
                                            }
                                            .frame(maxWidth: 200)
                                            Text("🏁 Add a flag manually")
                                                .padding(.top)
                                        }
                                        
                                        Spacer()
                                    }
                                    .buttonStyle(.bordered)
                                    .controlSize(.large)
                                    .padding(.vertical)
                                    
                                    
                                }
                                
                            // MARK: - Quiz Tab
                                HStack(alignment: .bottom) {
                                    Image(systemName: "lightbulb")
                                    Text("Quiz Tab")
                                }
                                .font(.title)
                                .padding(.vertical)
                                
                                Text("Have a small quiz to review the flags in your gallery. Kindly remind that you should add at least three flags before playing using random add or add flags manually in the gallery tab.")
                                    .padding(.horizontal)
                                
                            // MARK: - Drawing Tab
                                Group {
                                    HStack(alignment: .bottom) {
                                        Image(systemName: "scribble")
                                        Text("Drawing Tab")
                                    }
                                    .font(.title)
                                    .padding(.vertical)
                                    
                                    Text("If you want to create a flag on your hand, go to this tab. You can take a screenshot to share it with your friends or family")
                                        .padding(.horizontal)
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Button {
                                            } label: {
                                                Image(systemName: "shuffle")
                                                    .font(.largeTitle)
                                                    .padding(.bottom, 4)
                                                Text("Shuffle Flag")
                                                
                                            }
                                            .frame(maxWidth: 200)
                                            Text("🧐 Show another flag randomly at left")
                                                .padding(.top)
                                        }
                                        Spacer()
                                    }
                                    .buttonStyle(.bordered)
                                    .controlSize(.large)
                                    .padding(.vertical)
                                    
                                }
                            }
                            
                            

                            // MARK: - Button OK,
                            Button(
                                action: { self.presentationMode.wrappedValue.dismiss() },
                                label: {
                                    Text("OK, I know!")
                                        .font(.largeTitle)
                                }
                            )
                            .controlSize(.large)
                            .padding(.vertical)
                            
                            
                        } // End of Content VStack
                        .padding(.leading, 25)
                        
                        Spacer()
                    } // End of HStack
                    .frame(minWidth: geometry.size.width * 0.8)
                .frame(width: geometry.size.width)
                }
                
                
                
            } // End of Geometry View
            .navigationTitle("Walk Through")
            .navigationViewStyle(.stack)
//            .background(.darkBackground)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        } // End of NavigationView
        
        
        .preferredColorScheme(.dark)
    }
    
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
        WhatsNewView()
            .navigationViewStyle(.stack)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}


// MARK: - Function of check is new version

func getCurrentAppVersion() -> String {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    let version = (appVersion as! String)
    
    return version
}

func checkForUpdate() -> Bool {
    let version = getCurrentAppVersion()
    let savedVersion = UserDefaults.standard.string(forKey: "savedVersion")
    
    if savedVersion == version {
//        print("App is up to date!")
        return false
//        return true
    } else {
        UserDefaults.standard.set(version, forKey: "savedVersion")
        return true
    }
}

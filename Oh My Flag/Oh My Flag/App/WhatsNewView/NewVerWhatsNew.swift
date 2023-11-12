//
//  NewVerWhatsNew.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct NewVerWhatsNew: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
//        NavigationView {
            ScrollView {
                ZStack {
                    
                    VStack(alignment: .leading, spacing: 16.0) {
                        HStack {
                            Spacer()
                            Text("🏁")
                                .font(.system(size: 96))
                            Spacer()
                        }
//                        Image("Vector")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(height: 128)
//                            .frame(maxWidth: .infinity)
                        Text("Walk Through")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Feel free to tap done and explore by yourself")
                            .opacity(0.7)
                            .lineLimit(2)
                        Text("3 sections")
                            .opacity(0.7)
                        
                    }
                    .foregroundColor(.white)
                    .padding(16)
            //        .frame(width: 252, height: 329)
                    .background(LinearGradient(
                        gradient: Gradient(stops: [
                    .init(color: Color(#colorLiteral(red: 0.4000000059604645, green: 0.4941176474094391, blue: 0.9176470637321472, alpha: 1)), location: 0),
                    .init(color: Color(#colorLiteral(red: 0.4627451002597809, green: 0.29411765933036804, blue: 0.6352941393852234, alpha: 1)), location: 1)]),
                        startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5)))
                    VStack {
                        HStack {
                            Spacer()
                            Button("Done") {
                                dismiss()
                            }
                            .foregroundColor(.primary)
                            .opacity(0.9)
//                            .buttonStyle(.bordered)
                        }
                        Spacer()
                    }
                    .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("Hi, welcome to Oh My Flag 🥳. It's an app that helps you collect flags in your daily life.\n\nFeel free to tap done if you want to explore by yourself or you've known how to use it with step-by-step tutorials.\n\nStill want to know the details of the Oh My Flag App? Let me show you!")
                    
                    Group {
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
                                .buttonStyle(.bordered)
                                .controlSize(.large)
                                .padding(.vertical)
                                
                                Text("💨 Add a flag to your gallery randomly")
                                    .padding(.top)
                            }
                            Spacer()
                        }
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
                    HStack(alignment: .bottom) {
                        Image(systemName: "lightbulb")
                        Text("Quiz Tab")
                    }
                    .font(.title)
                    .padding(.vertical)
                    
                    Text("Have a small quiz to review the flags in your gallery. Kindly remind that you should add at least three flags before playing using random add or add flags manually in the gallery tab.")
                        .padding(.horizontal)
                    Group {
                        HStack(alignment: .bottom) {
                            Image(systemName: "scribble")
                            Text("Drawing Tab")
                        }
                        .font(.title)
                        .padding(.vertical)
                        
                        Text("If you want to create a flag on your hand, go to this tab. You can take a screenshot to share it with your friends or family.")
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
                                .buttonStyle(.bordered)
                                .controlSize(.large)
                                Text("🧐 Show another flag randomly at left")
                                    .padding(.top)
                            }
                            Spacer()
                        }
                        .padding(.vertical)
                        
                    }
                    HStack {
                        Spacer()
                        Button(
                            action: { self.presentationMode.wrappedValue.dismiss() },
                            label: {
                                Text("OK, I know!")
                                    .font(.largeTitle)
                            }
                        )
                        .controlSize(.large)
                        .padding(.vertical)
                        Spacer()
                    }
                }
                .padding()
                .background(Color(red: 0.1, green: 0.1, blue: 0.2))
                .preferredColorScheme(.dark)
//                .toolbar {
//                    ToolbarItem {
//                        Button("Done") {
//                            dismiss()
//                        }
//                    }
//                }
//                .navigationTitle("Walk Through")
            }
//        }
//        .navigationViewStyle(.stack)
    }
}

struct NewVerWhatsNew_Previews: PreviewProvider {
    static var previews: some View {
        NewVerWhatsNew()
    }
}

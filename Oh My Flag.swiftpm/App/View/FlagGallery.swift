//
//  FlagGallery.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct FlagGallery: View {
//    @FetchRequest(sortDescriptors: [
//        SortDescriptor(\.nameFlag, order: .reverse)
//    ]) var flagsEntitiesInFlagGallery: FetchedResults<FlagEntities>
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.nameFlag)
    ]) var flagsEntitiesInFlagGallery: FetchedResults<FlagEntities>
    
    @Environment(\.managedObjectContext) var mocInFlagGallery
    
//    let flag: FlagEntities
    
    @State private var showingGrid = true
    @State private var showingAddFlagView = false
    @State private var editIsPressed = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack(alignment: .center) {
                    RandomNewFlag()
                    Button {
                        showingAddFlagView.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .padding(.bottom, 4)
                            Text("Add New Flag")
                        }
                        .frame(maxWidth: 180, maxHeight: .infinity)
                        
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    
                    
                }
                .frame(maxHeight: 180, alignment: .center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    
                    ForEach(flagsEntitiesInFlagGallery) { flag in
                        NavigationLink {
                            FlagDetailView(flagInDetail: flag)
                        } label: {
                            ZStack(alignment: .topTrailing) {
                                if editIsPressed {
                                    Button {
                                        removePost(item: flag)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                            .font(.title)
                                    }
//                                    .offset(x: 5, y: -5)
                                }
                                BadgeFlagView(flag: flag)
                            }
                        }
                    }
                    .onDelete(perform: deleteFlags)
                }
                .padding([.horizontal, .bottom])
            } //: ScrollView Ends here
            .navigationTitle("Oh My Flag 🎉")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(editIsPressed ? "Done" : "Edit") {
//                        withAnimation {
                            editIsPressed.toggle()
//                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
                        

//                        let chosenFlagsTemp = flagsTemp.randomElement()!
//                        let flagInButton = FlagEntities(context: mocInFlagGallery)
//                        flagInButton.id = UUID()
//                        flagInButton.emojiFlag = chosenFlagsTemp
//
//                        try? mocInFlagGallery.save()
//
//                    } label: {
//                        showingGrid == true ? Image(systemName: "square.grid.2x2") : Image(systemName: "list.dash")
//                    }
                    
                    Button {
                        showingAddFlagView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
            } //: End of .toolbar
            .sheet(isPresented: $showingAddFlagView) {
                AddFlagView()
            }
            IntroView()
            
            
        } //: End of NavigationView
        .navigationViewStyle(.stack)
    } //: End of body
    
    private func removePost(item: FlagEntities) {
        withAnimation {
            mocInFlagGallery.delete(item)

            do {
                try mocInFlagGallery.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deleteFlags(at offsets: IndexSet) {
        for offset in offsets {
            let flag = flagsEntitiesInFlagGallery[offset]
            mocInFlagGallery.delete(flag)
        }
        try? mocInFlagGallery.save()
    }
}

struct FlagGallery_Previews: PreviewProvider {
    
    static var previews: some View {
        FlagGallery()
            .previewInterfaceOrientation(.landscapeRight)
    }
}

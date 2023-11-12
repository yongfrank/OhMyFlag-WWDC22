//
//  FlagDetailView.swift
//  OhMyFlag
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI
import CoreData

struct FlagDetailView: View {
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.nameFlag, order: .reverse)
    ]) var flagFetchInDetail: FetchedResults<FlagEntities>
    
    @State private var showingDeleteAlert = false
    @State private var showingEdit = false
    
    @Environment(\.managedObjectContext) var mocInFlagDetail
    
    @Environment(\.dismiss) var dismiss
    
    
    let flagInDetail: FlagEntities
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Text(flagInDetail.emojiFlag)
                        .font(.system(size: 160))
                        .scaledToFit()
                        
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text(flagInDetail.shortIntro)
                        .font(.title)
                    
                    VStack {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("More Details")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(flagInDetail.detailedIntro)
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width < geometry.size.height ? geometry.size.width : geometry.size.width * 0.7)
                    .frame(width: geometry.size.width)
                    
                }
                .padding(.bottom)
            }
            
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button() {
                    showingDeleteAlert = true
                } label: {
                    Label("Delete the flag", systemImage: "trash")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button() {
                    showingEdit = true
                } label: {
                    Label("Edit the flag", systemImage: "square.and.pencil")
                }
            }
        }
        .alert("Delete flag", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) { deleteFlag() }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        
        .sheet(isPresented: $showingEdit) {
            EditFlagView(flag: flagInDetail)
        }
        
        .navigationTitle(flagInDetail.nameFlag)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    func deleteFlag() {
        mocInFlagDetail.delete(flagInDetail)
        
        try? mocInFlagDetail.save()
        dismiss()
    }
    
    
}

//struct FlagDetailView_Previews: PreviewProvider {
//    static let mocInFlagDetail = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//    static var previews: some View {
//        let flag = FlagEntities(context: mocInFlagDetail)
//            flag.emojiFlag = "🏳️‍🌈"
//            flag.nameFlag = "Rainbow Flag"
//            flag.shortIntro = "six stripes of the rainbow"
//            flag.detailedIntro = "The Rainbow Flag emoji 🏳️‍🌈 portrays a rainbow flag, a flag with six stripes of the rainbow. This particular flag is used to represent the LGBTQ community and is used to express Pride in this community. Both the actual flag and the emoji depicting it are often referred to as the Pride Flag. The Rainbow Flag emoji 🏳️‍🌈 is used both by people who self-identify as LGBTQ as well as by their allies. While the Rainbow Flag emoji 🏳️‍🌈 is commonly used all of the time, its usage increases even more during Pride Month every year in June."
//        
//        return NavigationView {
//            FlagDetailView(flagInDetail: flag)
//        }
//    }
//}

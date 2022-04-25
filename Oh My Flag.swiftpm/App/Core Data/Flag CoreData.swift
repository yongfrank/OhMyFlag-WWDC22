import SwiftUI
import CoreData

@objc(FlagEntities)

public class FlagEntities: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var emojiFlag: String
    @NSManaged public var nameFlag: String
    @NSManaged public var shortIntro: String
    @NSManaged public var detailedIntro: String
}

extension FlagEntities: Identifiable {
    
}

import SwiftUI
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        let flagEntities = NSEntityDescription()
        flagEntities.name = "FlagEntities"
        flagEntities.managedObjectClassName = "FlagEntities"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .uuid
        flagEntities.properties.append(idAttribute)
        
        let nameFlagAttribute = NSAttributeDescription()
        nameFlagAttribute.name = "nameFlag"
        nameFlagAttribute.type = .string
        flagEntities.properties.append(nameFlagAttribute)
        
        let emojiFlagAttribute = NSAttributeDescription()
        emojiFlagAttribute.name = "emojiFlag"
        emojiFlagAttribute.type = .string
        flagEntities.properties.append(emojiFlagAttribute)
        
        let shortIntroAttribute = NSAttributeDescription()
        shortIntroAttribute.name = "shortIntro"
        shortIntroAttribute.type = .string
        flagEntities.properties.append(shortIntroAttribute)
        
        let detailedIntroAttribute = NSAttributeDescription()
        detailedIntroAttribute.name = "detailedIntro"
        detailedIntroAttribute.type = .string
        flagEntities.properties.append(detailedIntroAttribute)
        
        let model = NSManagedObjectModel()
        model.entities = [flagEntities]
        
        
        container = NSPersistentContainer(name: "OhMyFlag", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}


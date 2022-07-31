//
//  Persistence.swift
//  Task Management Beta
//
//  Created by Muhammad Nur Faqqih on 21/06/22.
//

import CoreData

//class PersistenceController: ObservableObject {
//
//    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
////        for _ in 0..<10 {
////            let newItem = Item(context: viewContext)
////            newItem.timestamp = Date()
////        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
//    let container: NSPersistentCloudKitContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentCloudKitContainer(name: "Task_Management_Beta")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//    }
//}

class PersistenceController: ObservableObject {
    
//    static let shared = PersistenceController()

let container: NSPersistentCloudKitContainer
let storeURL: URL
let storeDescription: NSPersistentStoreDescription

static let shared = PersistenceController()

init(inMemory: Bool = false) {
    storeURL = URL.storeURL(for: "group.chunkist", databaseName: "Task_Management_Beta") //see extension below for getting the storeURL for the app group
    container = NSPersistentCloudKitContainer(name: "Task_Management_Beta")
    storeDescription = NSPersistentStoreDescription(url: storeURL)
    storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.srifajar.chunkist.test")
    
    container.persistentStoreDescriptions = [storeDescription]
    
    if inMemory {
        container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { storeDescription, error in
        guard error == nil else {
            fatalError("Could not load persistent stores. \(error!)")
        }
    }
    
    let context = container.viewContext
    context.automaticallyMergesChangesFromParent = true
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    
//    NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: .NSPersistentStoreRemoteChange, object: nil)
}
    
    
}

public extension URL {
static func storeURL(for appGroup: String, databaseName: String) -> URL {
    guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
        fatalError("Shared file container could not be created.")
    }
    return fileContainer.appendingPathComponent("\(databaseName).sqlite")
}
    
}

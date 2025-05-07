//
//  Persistence.swift
//  AI_Calendar
//
//  Created by 심근웅 on 4/29/25.
//

import CoreData

struct PersistenceController {
  
  static let shared = PersistenceController()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "AI_Calendar")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
  
  /// Context의 변경점을 저장
  func save(context: NSManagedObjectContext? = nil) {
    let ctx = context ?? container.viewContext
    guard ctx.hasChanges else { return }
    do {
      try ctx.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  
}


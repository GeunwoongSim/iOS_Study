//
//  AI_CalendarApp.swift
//  AI_Calendar
//
//  Created by 심근웅 on 4/29/25.
//

import SwiftUI

@main
struct AI_CalendarApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      HomeView()
        .environmentObject(EventManager(content: persistenceController.container.viewContext))
//        .environment(
//          \.managedObjectContext,
//           persistenceController.container.viewContext
//        )
        
    }
  }
}


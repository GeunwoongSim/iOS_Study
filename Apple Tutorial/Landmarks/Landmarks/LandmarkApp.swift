//
//  Building_lists_and_navigationApp.swift
//  Building lists and navigation
//
//  Created by 심근웅 on 2/10/25.
//

import SwiftUI

@main
struct LandmarkApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}

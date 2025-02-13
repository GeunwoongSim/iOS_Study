//
//  Calculator_SwiftUIApp.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/13/25.
//

import SwiftUI

@main
struct Calculator_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(calculator: Calculator())
        }
    }
}

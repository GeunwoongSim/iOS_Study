//
//  FeedAppApp.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth

@main
struct FeedApp: App {
  
  @StateObject var authManager = AuthManager.shared
  
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      if authManager.isLogin {
        MainTabView()
      } else {
        LoginView()
      }
    }
  }
}


//
//  FeedAppApp.swift
//  FeedApp
//
//  Created by 심근웅 on 4/3/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    
    return true
  }
}


@main
struct FeedApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var appViewModel = AppViewModel()
  
  var body: some Scene {
    WindowGroup {
      if appViewModel.isLoggedIn {
        MainTabView()
          .transition(.opacity)
          .animation(.easeInOut, value: appViewModel.isLoggedIn)
      } else {
        LoginView()
          .transition(.opacity)
          .animation(.easeInOut, value: appViewModel.isLoggedIn)
      }
    }
    .environmentObject(appViewModel)
  }
}


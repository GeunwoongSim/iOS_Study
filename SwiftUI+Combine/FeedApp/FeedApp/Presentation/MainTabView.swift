//
//  MainTabView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI

struct MainTabView: View {
  
  @State private var previousTab = 0
  @State private var selectedTab = 0
  @State private var showPostView: Bool = false
  
  
  var body: some View {
    
    TabView(selection: $selectedTab) {
      FeedHomeView(refreshTrigger: $selectedTab)
        .tabItem {
          Image(systemName: "house")
        }
        .tag(0)
      
      Color.clear
        .tabItem {
          Image(systemName: "plus.app")
        }
        .tag(1)
      
      MyPageView()
        .tabItem {
          Image(systemName: "person.crop.square")
        }
        .tag(2)
    }
    .onChange(of: selectedTab) { oldValue, newValue in
      if newValue == 1 {
        showPostView = true
        selectedTab = previousTab
      }
      previousTab = selectedTab
    }
    .fullScreenCover(isPresented: $showPostView) {
      CreatePostView(showPostView: $showPostView)
    }
  }
}

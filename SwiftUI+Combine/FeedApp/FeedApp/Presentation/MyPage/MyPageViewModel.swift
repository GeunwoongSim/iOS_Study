//
//  MyPageViewModel.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import Foundation

@MainActor
final class MyPageViewModel: ObservableObject {
  @Published var myFeeds: [Feed] = []
  
  func fetchFeeds() {
    Task {
      guard let uid = FirebaseManager.shared.currentId else { return }
      do {
        myFeeds = try await FirebaseManager.shared.fetchFeeds(uid: uid)
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

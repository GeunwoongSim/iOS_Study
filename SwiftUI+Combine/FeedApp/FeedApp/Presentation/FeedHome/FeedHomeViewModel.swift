//
//  FeedHomeViewModel.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import Foundation

@MainActor
class FeedHomeViewModel: ObservableObject {
  @Published var feeds: [Feed] = []
  
  func fetchFeeds() {
    Task {
      do {
        feeds = try await FirebaseManager.shared.fetchAllFeeds()
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

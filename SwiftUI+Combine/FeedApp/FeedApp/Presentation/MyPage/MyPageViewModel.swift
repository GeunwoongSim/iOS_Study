//
//  MyPageViewModel.swift
//  Feed
//
//  Created by 심근웅 on 4/4/25.
//

import Foundation

@MainActor
final class MyPageViewModel: ObservableObject {
  
  @Published var myFeeds: [Feed] = []
  
  // 사용자의 피드 정보를 불러옴
  func fetchFeeds() {
    Task {
      
      guard let uid = AuthManager.shared.user?.uid else { return }
      
      do {
        myFeeds = try await FirestoreManager.shared.fetchFeeds(uid: uid)
      } catch {
        print(error.localizedDescription)
      }
      
    }
  }
}

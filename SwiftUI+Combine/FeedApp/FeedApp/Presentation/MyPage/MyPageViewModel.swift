//
//  MyPageViewModel.swift
//  Feed
//
//  Created by 심근웅 on 4/4/25.
//

import Foundation

final class MyPageViewModel: ObservableObject {
  
  @Published var myFeeds: [Feed] = []
  @Published var descending: Bool = true
  
  // 사용자의 피드 정보를 불러옴
  func fetchFeeds() {
    
    Task {
      guard let uid = AuthManager.shared.user?.uid else { return }
      
      do {
        let feeds = try await FirestoreManager.shared.fetchFeeds(
          uid: uid,
          descending: descending
        )
        await MainActor.run {
          self.myFeeds = feeds
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  // 사용자의 닉네임을 변경
  func updateNickname(newName: String) {
    guard let uid = AuthManager.shared.user?.uid else { return }
    
    Task {
      do {
        try await FirestoreManager.shared.updateNickname(uid: uid, name: newName)
        await AuthManager.shared.fetchUserName()
      } catch {
        print(error.localizedDescription)
      }
    }
    
  }
}

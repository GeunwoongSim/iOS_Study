//
//  FeedHomeViewModel.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import Foundation

class FeedHomeViewModel: ObservableObject {
  @Published var feeds: [Feed] = []
  @Published var nicknameDic: [String: String] = [:]
  
  // 전체 피드 정보를 불러옴
  func loadAllFeeds() {
    Task {
      do {
        try await fetchFeeds()
        await fetchNicknames(userIds: feeds.map { $0.userId })
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  
  // 전체 피드를 불러옴
  func fetchFeeds() async throws {
    let result = try await FirestoreManager.shared.fetchAllFeeds()
    
    await MainActor.run {
      self.feeds = result
    }
  }
  
  // 유저의 닉네임 정보를 불러옴
  func fetchNicknames(userIds: [String]) async {
    // 중복을 제거한 uid를 기반으로 정보를 불러옴
    for uid in Set(userIds) {
      if nicknameDic[uid] != nil { continue }
      
      let snapshot = try? await FirestoreManager.shared.loadUserDocument(uid: uid)
      
      if let data = snapshot?.data(), let name = data["name"] as? String {
        await MainActor.run {
          nicknameDic[uid] = name
        }
      }
    }
  }
}

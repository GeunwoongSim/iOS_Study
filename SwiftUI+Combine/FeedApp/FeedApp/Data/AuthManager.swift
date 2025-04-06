//
//  AuthManager.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseAuthCombineSwift
import Combine

final class AuthManager: ObservableObject {
  
  // MARK: -  Singleton 패턴
  static let shared = AuthManager()
  
  // MARK: - Properties
  private let auth = Auth.auth()
  @Published var user: User?
  @Published var userName: String?
  var isLogin: Bool { return user != nil }

  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Init
  private init() {
    // 로그인 정보가 변경되면 user 정보 변경
    auth
      .authStateDidChangePublisher()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] user in
        guard let self = self else { return }
        self.user = user
        Task { await self.fetchUserName() }
      }
      .store(in: &cancellables)
  }
 
  /// 로그아웃
  func logout() throws {
    try auth.signOut()
  }
  
  func fetchUserName() async {
    guard let uid = user?.uid else { return }
    
    do {
      let doc = try await FirestoreManager.shared.loadUserDocument(uid: uid)
      
      if let data = doc.data(),
         let name = data["name"] as? String {
        await MainActor.run {
          self.userName = name
        }
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}

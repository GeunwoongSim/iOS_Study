//
//  FirebaseAuthManager.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import Foundation
import FirebaseCore
import FirebaseAuthCombineSwift
import FirebaseAuth
import Combine

final class AuthManager: ObservableObject {
  
  // MARK: -  Singleton 패턴
  static let shared = AuthManager()
  private let auth = Auth.auth()
  
  // MARK: - Properties
  @Published var user: User?
  var isLogin: Bool {
    return user != nil
  }
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Init
  private init() {
    auth
      .authStateDidChangePublisher()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] user in
        self?.user = user
      }
      .store(in: &cancellables)
  }
  
  // MARK: - Auth Functions
  /// 로그인
  func login(email: String, password: String) -> AnyPublisher<User, Error> {
    return auth
      .signIn(withEmail: email, password: password)
      .map(\.user)
      .eraseToAnyPublisher()
  }
  
  /// 로그아웃
  func logout() throws {
    try auth.signOut()
  }
}

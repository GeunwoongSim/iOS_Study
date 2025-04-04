//
//  LoginViewModel.swift
//  FeedApp
//
//  Created by 심근웅 on 4/3/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
  @Published var email: String = "user01@comstudy.com"
  @Published var password: String = "123456"
  @Published var isLoggingIn: Bool = false
  @Published var isLoggedIn: Bool = false
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    
  }
  
  func login() async {
    isLoggingIn = true
    defer { isLoggingIn = false }
    
    // Combine을 Concurrency로 쓰기 위해서 사용
    await withCheckedContinuation { continuation in
      FirebaseManager.shared.login(email: email, password: password)
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
          if case let .failure(error) = completion {
            self?.isLoggedIn = false
            print(error.localizedDescription)
            continuation.resume()
          }
          
        } receiveValue: { [weak self] result in
          print("✅ 로그인 성공: \(result.user.uid)")
          self?.isLoggedIn = true
          continuation.resume()
        }
        .store(in: &cancellables)
    }
  }
}


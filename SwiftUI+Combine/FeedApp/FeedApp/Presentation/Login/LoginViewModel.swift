//
//  LoginViewModel.swift
//  FeedApp
//
//  Created by 심근웅 on 4/3/25.
//

import Foundation
import SwiftUI
import Combine

final class LoginViewModel: ObservableObject {
  
  // MARK: - Properties
  @Published var email: String = "user01@comstudy.com"
  @Published var password: String = "123456"
  @Published var isLogining: Bool = false // 인디케이터 작동변수
  
  private var cancellables = Set<AnyCancellable>()

  /// 로그인
  func login() {
    isLogining = true
    
    AuthManager.shared.login(email: email, password: password)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLogining = false
        
        if case let .failure(error) = completion {
//          self?.errorMessage = error.localizedDescription
        }
      } receiveValue: { _ in
        // 로그인 성공 시 AuthManager가 상태를 업데이트함
      }
      .store(in: &cancellables)
  }
  
}

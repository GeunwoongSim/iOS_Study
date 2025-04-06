//
//  LoginViewModel.swift
//  FeedApp
//
//  Created by 심근웅 on 4/7/25.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: ObservableObject {
  
  @Published var showAlert: Bool = false
  var errorMessage: String?
  
  // 구글 로그인 진행
  func googleLogin() {
    Task {
      do {
        let user = try await GoogleSignInManager.shared.signInGoogle()
        // 기존 정보가 없음
        if try await FirestoreManager.shared.isFirstSignIn(uid: user.uid) {
          try await FirestoreManager.shared.addUserData(user: user)
        }
      } catch {
        errorMessage = error.localizedDescription
        showAlert = true
      }
    }
  }
}

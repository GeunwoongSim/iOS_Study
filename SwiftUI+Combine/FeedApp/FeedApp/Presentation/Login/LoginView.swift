//
//  LoginView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
  @State private var errorMessage: String?
  @State var showAlert: Bool = false
  
  var body: some View {
    VStack(spacing: 40) {
      Spacer()
      
      Text("로그인 후 시작하세요")
        .font(.title2)
        .fontWeight(.medium)
      
      GoogleSignInButton {
        Task {
          do {
            let user = try await GoogleSignInManager.shared.signInGoogle()
            print(user)
          } catch {
            errorMessage = error.localizedDescription
            showAlert = true
          }
        }
      }
      
      Spacer()
    }
    .padding()
    .alert("로그인 실패", isPresented: $showAlert) {
      Button("확인", role: .cancel) {}
    } message: {
      Text(errorMessage ?? "알 수 없는 오류입니다.")
    }
  }
}


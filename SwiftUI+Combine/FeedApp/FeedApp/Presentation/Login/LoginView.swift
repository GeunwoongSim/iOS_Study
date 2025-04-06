//
//  LoginView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
  @StateObject private var viewModel = LoginViewModel()
  
  var body: some View {
    VStack(spacing: 40) {
      Spacer()
      
      Text("로그인 후 시작하세요")
        .font(.title2)
        .fontWeight(.medium)
      
      GoogleSignInButton {
        viewModel.googleLogin()
      }
      
      Spacer()
    }
    .padding()
    .alert("로그인 실패", isPresented: $viewModel.showAlert) {
      Button("확인", role: .cancel) {}
    } message: {
      Text(viewModel.errorMessage ?? "알 수 없는 오류입니다.")
    }
  }
}


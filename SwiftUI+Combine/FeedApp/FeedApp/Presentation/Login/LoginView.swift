//
//  ContentView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/3/25.
//

import SwiftUI

struct LoginView: View {
  @StateObject var viewModel: LoginViewModel = LoginViewModel()

  var body: some View {
    VStack(spacing: 20) {
      // 이메일 입력필드
      TextField ("Email", text: $viewModel.email)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
      
      // 비밀번호 입력 필드
      SecureField ("Password", text: $viewModel.password)
        .textFieldStyle(.roundedBorder)
        .autocapitalization(.none)
      
      // 로그인 버튼
      Button {
        print("버튼 클릭")
        viewModel.login()
      } label: {
        if viewModel.isLogining {
          ProgressView()
        } else {
          Text("Login")
            .font(.headline)
            .foregroundStyle(.white)
        }
      }
      .disabled(viewModel.isLogining)
      .padding()
      .background(Color(.systemBlue))
      .cornerRadius(10)
      .frame(maxWidth: .infinity)
    }
    .padding()
  }
}

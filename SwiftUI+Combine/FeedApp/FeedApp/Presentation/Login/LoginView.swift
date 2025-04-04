//
//  ContentView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/3/25.
//

import SwiftUI

struct LoginView: View {
  @EnvironmentObject var appViewModel: AppViewModel
  @StateObject var viewModel: LoginViewModel = LoginViewModel()

  var body: some View {
    VStack(spacing: 20) {
      TextField ("Email", text: $viewModel.email)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)
      
      SecureField ("Password", text: $viewModel.password)
        .textFieldStyle(.roundedBorder)
        .autocapitalization(.none)
      
      Button {
        viewModel.login()
        if viewModel.isLoggedIn {
          
        }
        
//        Task {
//          await viewModel.login()
//          if viewModel.isLoggedIn {
//            appViewModel.isLoggedIn = true
//          }
//        }
      } label: {
        Text("Login")
          .font(.headline)
          .foregroundStyle(.white)
      }
      .padding()
      .background(Color(.systemBlue))
      .cornerRadius(10)
      .frame(maxWidth: .infinity)
    }
    .padding()
  }
}

#Preview {
  LoginView()
    .environmentObject(AppViewModel())
  
}



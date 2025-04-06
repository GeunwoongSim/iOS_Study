//
//  MyPageView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI

struct MyPageView: View {
  @StateObject private var authManager = AuthManager.shared
  @StateObject private var viewModel = MyPageViewModel()
  @State private var showNameEdit = false
  @State private var newName = ""
  
  
  let columns = [
    GridItem(.flexible(), spacing: 0),
    GridItem(.flexible(), spacing: 0),
    GridItem(.flexible(), spacing: 0)
  ]
  
  var body: some View {
    NavigationStack {
      
      ScrollView {
        LazyVGrid(columns: columns, spacing: 0) {
          ForEach(viewModel.myFeeds) { post in
            AsyncImage(url: URL(string: post.imageURL)) { image in
              image
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(maxWidth: .infinity)
                .clipped()
            } placeholder: {
              Rectangle()
                .fill(Color.gray.opacity(0.2))
                .aspectRatio(1, contentMode: .fill)
            }
          }
        }
      }
      .refreshable { viewModel.fetchFeeds() }
      .onAppear { viewModel.fetchFeeds() }
      .navigationTitle("\(authManager.userName ?? "사용자")")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Menu {
            
            Button(viewModel.descending ? "오래된 순 보기" : "최신 순 보기") {
              viewModel.descending.toggle()
              viewModel.fetchFeeds()
            }
            
            Button("닉네임 변경") {
              showNameEdit = true
            }
            
            Button("로그아웃") {
              try? authManager.logout()
            }
            
          } label: {
            Image(systemName: "ellipsis")
          }
          .alert("닉네임 변경", isPresented: $showNameEdit) {
            TextField("새 닉네임", text: $newName)
            Button("취소", role: .cancel) { }
            Button("저장") {
              viewModel.updateNickname(newName: newName)
            }
          } message: {
            Text("새 닉네임을 입력하세요")
          }
        }
      } // toolbar 종료
    }
    
  } // body 종료
} // MyPageVew 종료

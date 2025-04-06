//
//  MyPageView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI

struct MyPageView: View {
  @StateObject private var viewModel = MyPageViewModel()
  
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
      .onAppear { viewModel.fetchFeeds() }
      .navigationTitle("\(AuthManager.shared.user?.uid ?? "사용자")")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Menu {
            Button("오래된 순 보기") {
              
            }
            Button("닉네임 변경") {
              print("닉네임 변경")
            }
            Button("로그아웃") {
              try? AuthManager.shared.logout()
            }
            
          } label: {
            Image(systemName: "ellipsis")
          }
        }
      } // toolbar 종료
    }
    
  } // body 종료
} // MyPageVew 종료

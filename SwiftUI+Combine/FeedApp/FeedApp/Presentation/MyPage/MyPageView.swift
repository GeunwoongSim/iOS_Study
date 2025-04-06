//
//  MyPageView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
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
      .onAppear {
        viewModel.fetchFeeds()
      }
      .navigationTitle("\(FirebaseManager.shared.currentId ?? "알 수 없음")")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Menu {
            Button ("로그아웃") {
              try? AuthManager.shared.logout()
            }
          } label: {
            Image(systemName: "ellipsis")
          }
        }
      }
    }
  }
}

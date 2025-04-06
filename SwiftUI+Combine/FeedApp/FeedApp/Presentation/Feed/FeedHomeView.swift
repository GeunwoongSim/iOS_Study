//
//  FeedHomeView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI

struct FeedHomeView: View {
  @Binding var refreshTrigger: Int
  @StateObject var viewModel = FeedHomeViewModel()
  
  var body: some View {
    NavigationView {
      List(viewModel.feeds) { feed in
        let name = viewModel.nicknameDic[feed.userId] ?? "사용자"
        FeedView(info: feed, nickname: name)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
      }
      .listStyle(.plain)
      .navigationTitle("Feed")
      .navigationBarTitleDisplayMode(.inline)
      .onChange(of: refreshTrigger) { _, newValue in
        if newValue == 0 {
          viewModel.loadAllFeeds()
        }
      }
      .onAppear {
        viewModel.loadAllFeeds()
      }
    }
    .refreshable {
      viewModel.loadAllFeeds()
    }
  }
}

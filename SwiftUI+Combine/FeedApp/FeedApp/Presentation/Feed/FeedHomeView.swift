//
//  FeedHomeView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI

struct FeedHomeView: View {
  
  @StateObject private var viewModel = FeedHomeViewModel()
  
  var body: some View {
    NavigationView {
      List(viewModel.feeds) { feed in
        FeedView(info: feed)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
      }
      .listStyle(.plain)
      .navigationTitle("Feed")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        viewModel.fetchFeeds()
      }
    }
    .refreshable {
      viewModel.fetchFeeds()
    }
  }
}

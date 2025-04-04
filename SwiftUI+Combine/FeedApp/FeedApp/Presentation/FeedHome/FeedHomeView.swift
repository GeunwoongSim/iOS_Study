//
//  FeedHomeView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import SwiftUI

struct FeedHomeView: View {
  
  @StateObject private var viewModel = FeedHomeViewModel()
  
  var body: some View {
    NavigationView {
      List(viewModel.feeds) { feed in
        
        VStack(alignment: .leading, spacing: 8) {
          
          ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
              AsyncImage(url: URL(string: feed.imageURL)) { image in
                image
                  .resizable()
                  .scaledToFill()
                  .frame(width: geometry.size.width, height: geometry.size.height)
                  .clipped()
              } placeholder: {
                Rectangle().fill(Color.gray.opacity(0.2))
                  .frame(width: geometry.size.width, height: geometry.size.height)
              }
            }
            .frame(height: UIScreen.main.bounds.width)
            
            Text(feed.userId)
              .foregroundStyle(.white)
              .font(.title3)
              .bold()
          }
          Text(feed.caption)
            .font(.body)
            .padding(.horizontal, 4)
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .navigationTitle("FeedApp")
      .onAppear {
        viewModel.fetchFeeds()
      }
    }
    .refreshable {
      viewModel.fetchFeeds()
    }
  }
}

#Preview {
  FeedHomeView()
}

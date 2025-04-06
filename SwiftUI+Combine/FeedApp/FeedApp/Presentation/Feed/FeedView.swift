//
//  FeedView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import SwiftUI

struct FeedView: View {
  
  // 피드 정보
  let info: Feed
  let nickname: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      
      Divider()
        .background(Color.black)
      
      Text(nickname)
        .foregroundStyle(.black)
        .font(.title3)
        .bold()
        .padding(.leading, 16)
        .frame(height: 40)
      
      GeometryReader { geometry in
        AsyncImage(url: URL(string: info.imageURL)) { image in
          image
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: geometry.size.width)
            .clipped()
        } placeholder: {
          Rectangle().fill(Color.gray.opacity(0.2))
            .frame(width: geometry.size.width, height: geometry.size.width)
        }
      }
      .frame(height: UIScreen.main.bounds.width)
      
      if info.caption != "" {
        Text(info.caption)
          .font(.body)
          .padding(8)
      }
      
    }
  }
}


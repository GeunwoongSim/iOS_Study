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
  
  var body: some View {
    VStack(alignment: .leading) {
      
      ZStack(alignment: .topLeading) {
        GeometryReader { geometry in
          AsyncImage(url: URL(string: info.imageURL)) { image in
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
        
        Text(info.userId)
          .foregroundStyle(.white)
          .font(.title3)
          .bold()
      }
      
      Text(info.caption)
        .font(.body)
        .padding(.horizontal, 4)
    }
  }
}


//
//  CreatePostView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import SwiftUI
import PhotosUI

struct CreatePostView: View {
  
  // MARK: - Navigation 이동 관련 프로퍼티
  @Environment(\.dismiss) private var dismiss
  @State private var navigateToDetail = false
  @Binding var showPostView: Bool
  
  // MARK: - PhotosUI 관련 프로퍼티
  @State private var selectedImage: UIImage?
  
    var body: some View {
      NavigationStack {
        VStack {
          GeometryReader { geometry in
            if let image = selectedImage {
              Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.width)
                .clipped()
            } else {
              Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: geometry.size.width, height: geometry.size.width)
                .overlay(Text("이미지를 선택하세요"))
            }
          }
          .frame(height: UIScreen.main.bounds.width)
          EmbeddedImagePicker(selectedImage: $selectedImage)
        }
        .navigationTitle("새 게시물")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button("닫기") {
              dismiss()
            }
          }
          
          ToolbarItem(placement: .topBarTrailing) {
            Button("다음") {
              navigateToDetail = true
            }
            .disabled(selectedImage == nil)
          }
        }
        .navigationDestination(isPresented: $navigateToDetail) {
          if let image = selectedImage {
            CreatePostDetailView(
              showPostView: $showPostView,
              image: image
            )
          }
        }
      }
    }
}

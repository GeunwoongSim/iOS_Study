//
//  CreatePostDetailView.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import SwiftUI

struct CreatePostDetailView: View {
  
  // MARK: - 프로퍼티
  private let viewModel = CreatePostViewModel()
  @Binding var showPostView: Bool
  var image: UIImage
  
  @State private var caption: String = ""
  @FocusState private var isTextEditorFocused: Bool
  
  var body: some View {
    VStack {
      // 이미지
      Image(uiImage: image)
        .resizable()
        .scaledToFill()
        .frame(width: 300 , height: 300)
        .cornerRadius(12)
      
      // 텍스트에디터(플레이스홀더 포함)
      ZStack(alignment: .topLeading) {
        TextEditor(text: $caption)
          .padding(8)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
          .focused($isTextEditorFocused)
        
        if caption.isEmpty {
          Text("내용 추가...")
            .foregroundColor(.gray)
            .padding(12)
        }
      }
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.gray.opacity(0.3))
      )
      Spacer()
    }
    .navigationTitle("새 게시물")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("완료") {
          viewModel.savePost(image: image, caption: caption)
          showPostView = false
        }
      }
    }
    .onTapGesture {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil, for: nil)
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        isTextEditorFocused = true
      }
    }
  }
}


//
//  CreatePostDetailViewModel.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import Foundation
import SwiftUI

final class CreatePostViewModel {
  
  private let auth = AuthManager.shared
  private let store = FirestoreManager.shared
  
  func savePost(image: UIImage, caption: String) {
    
    guard let uid = auth.user?.uid,
          let imageData = image.jpegData(compressionQuality: 0.6)
    else { return }
   
    let fileName = UUID().uuidString
    
    Task {
      do {
        try await store.savePost(
          uid: uid,
          fileName: fileName,
          image: imageData,
          caption: caption
        )
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

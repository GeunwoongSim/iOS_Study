//
//  FirebaseManager.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuthCombineSwift
import FirebaseAuth

final class FirebaseManager {
  
  // MARK: -  Singleton 패턴
  static let shared = FirebaseManager()
  private init() { }
  
  // MARK: - 서비스 접근 정보
  let auth = Auth.auth()
  let storage = Storage.storage().reference()
  let feedsStore = Firestore.firestore().collection("feeds")
  
  // 현재 로그인된 유저 정보
  var currentUser: User? {
    return auth.currentUser
  }
  var currentId: String? {
    return currentUser?.uid
  }
}

// MARK: - 로그인
extension FirebaseManager {
  
  /// 로그인
  func login(email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
    return auth
      .signIn(withEmail: email, password: password)
      .eraseToAnyPublisher()
  }
  
  /// 로그아웃
  func logout() async throws {
    try auth.signOut()
  }
  
}

// MARK: - 피드
extension FirebaseManager {
  
  func fetchAllFeeds() async throws -> [Feed] {
    let snapshot = try await feedsStore
      .order(by: "timestamp", descending: true)
      .getDocuments()
    
    let feeds = snapshot.documents.compactMap { Feed($0) }
    return feeds
  }
  
  ///  파이어스토어에서 사용자에 따른 피드를 불러옵니다.
  /// - Parameter uid: 사용자의 uid
  /// - Returns: 피드정보들
  func fetchFeeds(uid: String) async throws -> [Feed] {
    let snapshot = try await feedsStore
      .whereField("userId", isEqualTo: uid)
      .order(by: "timestamp", descending: true)
      .getDocuments()
    
    let feeds = snapshot.documents.compactMap { Feed($0) }
    return feeds
  }
  
  
  /// 파이어스토어에 피드를 저장합니다.
  /// - Parameters:
  ///   - image: 사용자가 선택한 UIImage
  ///   - caption: 피드에 작성한 내용
  func savePost(image: UIImage, caption: String) async {
    guard let uid = currentId else {
      // 에러 - 로그인정보 없음
      return
    }
    guard let imageData = image.jpegData(compressionQuality: 0.6) else {
      // 에러 - 이미지데이터를 생성못함
      return
    }
    let fileName = UUID().uuidString
    let storageRef = storage.child("feeds/\(fileName).jpg")
    
    do {
      // 파일 업로드
      let _ = try await storageRef.putDataAsync(imageData, metadata: nil)
      // 다운로드 URL 가져옴
      let url = try await storageRef.downloadURL()
      
      // 저장할 데이터의 형태
      let data: [String: Any] = [
        "caption": caption,
        "imageURL": url.absoluteString,
        "timestamp": Timestamp(date: Date()),
        "userId": uid
      ]
      
      // 실제 데이터 저장
      try await feedsStore.addDocument(data: data)
      
    } catch {
      print(error.localizedDescription)
    }
  }
}

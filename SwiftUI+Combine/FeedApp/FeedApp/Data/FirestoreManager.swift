//
//  FirestoreManager.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class FirestoreManager {
  
  // MARK: -  Singleton 패턴
  static let shared = FirestoreManager()
  private init() { }
  
  // MARK: - Properties
  let storage = Storage.storage().reference()
  private let feedStore = Firestore.firestore().collection("feeds")
  
  
  // MARK: - 전체 피드 fetch
  /// 파이어스토어에서 전체 피드 정보를 불러옵니다.
  func fetchAllFeeds() async throws -> [Feed] {
    let snapshot = try await feedStore
      .order(by: "timestamp", descending: true)
      .getDocuments()
    
    let feeds = snapshot.documents.compactMap { Feed($0) }
    return feeds
  }
  
  // MARK: - 특정 유저의 피드 fetch
  ///  파이어스토어에서 사용자의 피드 정보를 불러옵니다.
  /// - Parameter uid: 사용자의 uid
  /// - Returns: 피드정보들
  func fetchFeeds(uid: String) async throws -> [Feed] {
    let snapshot = try await feedStore
      .whereField("userId", isEqualTo: uid)
      .order(by: "timestamp", descending: true)
      .getDocuments()
    
    let feeds = snapshot.documents.compactMap { Feed($0) }
    return feeds
  }
  
  /// 파이어스토어에 피드를 저장합니다.
  /// - Parameters:
  ///   - uid: 사용자의 uid
  ///   - fileName: 저장할 파일의 이름
  ///   - image: 사용자가 선택한 UIImage의 jpegData
  ///   - caption: 피드에 작성한 내용
  func savePost(
    uid: String,
    fileName: String,
    image: Data,
    caption: String
  ) async throws {
    
    let storageRef = storage.child("feeds/\(fileName).jpg")
    let _ = try await storageRef.putDataAsync(image, metadata: nil)
    let url = try await storageRef.downloadURL()
    
    // 저장할 데이터의 형태
    let data: [String: Any] = [
      "caption": caption,
      "imageURL": url.absoluteString,
      "timestamp": Timestamp(date: Date()),
      "userId": uid
    ]
    
    // 실제 데이터 저장
    try await feedStore.addDocument(data: data)
  }
}

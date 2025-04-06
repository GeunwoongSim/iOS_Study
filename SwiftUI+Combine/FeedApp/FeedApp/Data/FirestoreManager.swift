//
//  FirestoreManager.swift
//  FeedApp
//
//  Created by 심근웅 on 4/6/25.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

final class FirestoreManager {
  
  // MARK: -  Singleton 패턴
  static let shared = FirestoreManager()
  private init() { }
  
  // MARK: - Properties
  let storage = Storage.storage().reference()
  private let feedStore = Firestore.firestore().collection("feeds")
  private let userStore = Firestore.firestore().collection("users")

}

// MARK: - 사용자 정보와 관련된 Firestore
extension FirestoreManager {
  
  /// 사용자의 닉네임을 변경합니다
  /// - Parameters:
  ///   - uid: 사용자의 uid
  ///   - name: 변경할 닉네임
  func updateNickname(uid: String, name: String) async throws {
    // 닉네임 데이터 수정
    try await userStore.document(uid).updateData(["name": name])
  }
  
  /// 사용자 정보를 Firestore에 저장합니다
  /// - Parameter user: 사용자 정보
  func addUserData(user: User) async throws {
    let userData: [String: Any] = [
      "uid": user.uid,
      "email": user.email ?? "",
      "name": user.displayName ?? "사용자",
      "profileURL": user.photoURL?.absoluteString ?? "",
      "joinedAt": Timestamp(date: Date())
    ]
    
    try await userStore.document(user.uid).setData(userData)
  }
  
  /// 사용자 정보가 Firestore에 있는지 확인합니다
  /// - Parameter uid: 확인할 사용자의 uid
  /// - Returns: 사용자가 처음 로그인하면 true, 처음이 아니면 false를 반환합니다.
  func isFirstSignIn(uid: String) async throws -> Bool {
    // 생성된 정보가 있는지 확인
    let snapshot = try await loadUserDocument(uid: uid)
    return !snapshot.exists
  }
  
  
  /// 사용자 정보를 반환합니다.
  /// - Parameter uid: 사용자의 uid
  /// - Returns: 사용자에 대한 정보가 담긴 DocumentSnapshot을 반환합니다.
  func loadUserDocument(uid: String) async throws -> DocumentSnapshot {
    return try await userStore.document(uid).getDocument()
  }
}


// MARK: - 피드와 관련된 Firestore
extension FirestoreManager {
  
  // MARK: - 전체 피드 fetch
  /// Firestore에서 전체 피드 정보를 불러옵니다.
  func fetchAllFeeds() async throws -> [Feed] {
    let snapshot = try await feedStore
      .order(by: "timestamp", descending: true)
      .getDocuments()
    
    let feeds = snapshot.documents.compactMap { Feed($0) }
    return feeds
  }
  
  // MARK: - 특정 유저의 피드 fetch
  ///  Firestore에서 사용자의 피드 정보를 불러옵니다.
  /// - Parameter uid: 사용자의 uid
  /// - Returns: 피드정보들
  func fetchFeeds(uid: String, descending: Bool = true) async throws -> [Feed] {
    let snapshot = try await feedStore
      .whereField("userId", isEqualTo: uid)
      .order(by: "timestamp", descending: descending)
      .getDocuments()
    
    let feeds = snapshot.documents.compactMap { Feed($0) }
    return feeds
  }
  
  /// Firestore에 피드를 저장합니다.
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

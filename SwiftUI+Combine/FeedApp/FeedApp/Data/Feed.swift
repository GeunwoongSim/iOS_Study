//
//  Feed.swift
//  FeedApp
//
//  Created by 심근웅 on 4/4/25.
//

import Foundation
import FirebaseFirestore

struct Feed: Identifiable {
  let id: String
  let caption: String
  let imageURL: String
  let timestamp: Date
  let userId: String
  
  init?(_ document: DocumentSnapshot) {
    guard let data = document.data() else { return nil }
    self.id = document.documentID
    self.caption = data["caption"] as? String ?? ""
    self.imageURL = data["imageURL"] as? String ?? ""
    self.userId = data["userId"] as? String ?? ""
    
    if let timestamp = data["timestamp"] as? Timestamp {
      self.timestamp = timestamp.dateValue()
    } else {
      self.timestamp = Date()
    }
  }
}

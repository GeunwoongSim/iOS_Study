//
//  LLMChatViewModel.swift
//  AI_Calendar
//
//  Created by 심근웅 on 4/30/25.
//

import Foundation
import SwiftUI

struct ChatMsg: Identifiable {
  let id: UUID = UUID()
  let role: Role
  let content: String
  
  /// 사용자와 LLM AI의 답변을 구분
  enum Role: String {
    case user, assistant
  }
}

class LLMChatViewModel: ObservableObject {
  @Published var messages: [ChatMsg] = []
  private let repo: CoreDateRepository
  
  init(repo: CoreDateRepository = CoreDateRepository.shared) {
    self.repo = repo
  }
  
  func messagesSend(_ text: String) {
    let msg = ChatMsg(role: .user, content: text)
    messages.append(msg)
    
    Task {
      let result = try await AlanService.shared.send(text: msg.content)
      print(result)
      switch result[1] {
      case "Add":
        let date = parse(result[0]) ?? Date()
        repo.addEvent(title: result[2], date: date)
      case "Remove": return
//        let all = (try? repo.fetchAll()) ?? []
//        if let e = all.first(where: { $0.id?.uuidString == json["Id"] }) {
//          repo.delete(e)
//        }
      default:
        return
      }
    }
  }
  
  func parse(_ str: String) -> Date? {
    let fm = DateFormatter()
    fm.locale = Locale(identifier: "ko_KR")
    
    fm.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    if let d = fm.date(from: str) { return d }
    
    fm.dateFormat = "yyyy-MM-dd"
    return fm.date(from: str)
  }
}

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
  
  func messagesSend(_ text: String) {
    let msg = ChatMsg(role: .user, content: text)
    messages.append(msg)
  }
}

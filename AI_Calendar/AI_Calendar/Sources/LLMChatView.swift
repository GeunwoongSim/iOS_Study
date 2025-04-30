//
//  LLMChatView.swift
//  AI_Calendar
//
//  Created by 심근웅 on 4/29/25.
//

import SwiftUI

struct LLMChatView: View {
  
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel = LLMChatViewModel()
  @State private var inputText = ""
  
    var body: some View {
      NavigationView {
        VStack {
          ScrollView {
            ForEach(viewModel.messages) { msg in
              HStack {
                if msg.role == .assistant {
                  Text(msg.content)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                  Spacer()
                } else {
                  Spacer()
                  Text(msg.content)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                }
              }
              .padding(.horizontal)
            }
          }
          
          Divider()
          
          // 입력 필드
          HStack {
            TextField("메시지 입력...", text: $inputText)
              .textFieldStyle(.roundedBorder)
            
            Button {
              let text = inputText.trimmingCharacters(in: .whitespaces)
              guard !text.isEmpty else { return }
              viewModel.messagesSend(text)
              inputText = ""
            } label: {
              Text("전송")
            }
          }
          .padding()
        }
        .navigationTitle("AI 대화")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("닫기") {
              dismiss()
            }
          }
        }
        
      }
    }
}

#Preview {
    LLMChatView()
}

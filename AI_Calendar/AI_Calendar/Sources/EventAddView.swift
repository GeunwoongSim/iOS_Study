//
//  EventAddView.swift
//  AI_Calendar
//
//  Created by 심근웅 on 4/29/25.
//

import SwiftUI

struct EventAddView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  // MARK: - 입력데이터
  @State private var title: String = ""
  @State private var date: Date = Date()
  @State private var memo: String = ""
  
  var body: some View {
    NavigationView {
      Form {
        Section("기본 정보") {
          TextField("제목", text: $title)
          DatePicker("날짜 및 시간", selection: $date)
        }
        Section("메모") {
          TextEditor(text: $memo)
            .frame(height: 100)
        }
      }
      .navigationTitle("일정 추가")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("저장") {
            CoreDateRepository.shared.addEvent(
              title: title,
              date: date,
              memo: memo
            )
            dismiss()
          }
        }
        ToolbarItem(placement: .cancellationAction) {
          Button("취소") {
            dismiss()
          }
        }
      }
    }
  }
}

#Preview {
  EventAddView()
}


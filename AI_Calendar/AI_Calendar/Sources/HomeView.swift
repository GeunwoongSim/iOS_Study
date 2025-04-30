//
//  HomeView.swift
//  AI_Calendar
//
//  Created by 심근웅 on 4/29/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
  @EnvironmentObject var eventManager: EventManager
  
  @State private var showEventAddView: Bool = false
  @State private var showLLMAIView: Bool = false
  
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottomTrailing) {
        List(eventManager.events) { event in
          HStack(alignment: .top, spacing: 12) {
            // 날짜
            Text(event.date ?? Date(), style: .date)
              .font(.subheadline)
              .frame(width: 80, alignment: .leading)
            
            // 제목 + 메모
            VStack(alignment: .leading, spacing: 4) {
              Text(event.title ?? "제목 없음")
                .font(.headline)
              if let memo = event.memo, !memo.isEmpty {
                Text(memo)
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }
            }
          }
          .padding(.vertical, 6)
        }
        
        Button {
          showLLMAIView = true
        } label: {
          Image(systemName: "bolt.horizontal.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundStyle(.white)
        }
        .frame(width: 60, height: 60)
        .background(Color.blue)
        .clipShape(Circle())
        .padding(16)
      }
      .navigationTitle("일정 목록")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button {
            showEventAddView = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
    .sheet(isPresented: $showEventAddView) {
      EventAddView()
    }
    .sheet(isPresented: $showLLMAIView) {
      LLMChatView()
    }
  }
}

#Preview {
  let persistenceController = PersistenceController.shared
  HomeView()
    .environmentObject(EventManager(content: persistenceController.container.viewContext))
}


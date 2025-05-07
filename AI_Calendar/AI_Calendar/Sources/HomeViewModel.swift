//
//  HomeViewModel.swift
//  AI_Calendar
//
//  Created by 심근웅 on 5/7/25.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
  @Published var events: [Event] = []
  private let repo: CoreDateRepository
  
  init(repo: CoreDateRepository = CoreDateRepository.shared) {
    self.repo = repo
    loadEvents()
  }
  
  func loadEvents() {
    events = (try? repo.fetchAll()) ?? []
  }
  
  func deleteEvent(e: Event) {
    repo.delete(e)
  }
  
}

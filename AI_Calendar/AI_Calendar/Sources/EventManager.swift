//
//  EventManager.swift
//  AI_Calendar
//
//  Created by 심근웅 on 4/29/25.
//

import Foundation
import SwiftUI
import CoreData

/// 일정 CRUD를 관리하는 ObservableObject 매니저
final class EventManager: ObservableObject {
  
  private let viewContext: NSManagedObjectContext
  
  @Published var events: [Event] = []
  
  init(content: NSManagedObjectContext) {
    self.viewContext = content
    fetchEvents()
  }
  
  func fetchEvents(
    predicate: NSPredicate? = nil,
    sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(keyPath: \Event.date, ascending: true)]
  ) {
    let request: NSFetchRequest<Event> = Event.fetchRequest()
    request.predicate = predicate
    request.sortDescriptors = sortDescriptors
    
    do {
      events = try viewContext.fetch(request)
    } catch {
      print("Fetch failed:", error)
    }
  }
  
  /// 새로운 일정 생성
  /// - Parameters:
  ///   - title: 일정 이름
  ///   - date: 일정 날짜
  ///   - memo: title, date를 제외한 일정에 필요한 내용
  public func addEvent(title: String, date: Date, memo: String?) {
    let newEvent = Event(context: viewContext)
    newEvent.id = UUID()
    newEvent.title = title
    newEvent.date = date
    newEvent.memo = memo
    
    saveContext()
    fetchEvents()
  }
  
  /// 여기도 추후 LLM으로도 수정하기 위해 변경필요
  public func updateEvent(_ event: Event, newTitle: String, newDate: Date, newMemo: String?) {
    event.title = newTitle
    event.date = newDate
    event.memo = newMemo
    
    saveContext()
    fetchEvents()
  }
  
  /// event를 받아서 해당 event를 삭제하는데 추후 변경필요 - LLM으로도 삭제하기 위해
  public func deleteEvent(_ event: Event) {
    viewContext.delete(event)
    saveContext()
    fetchEvents()
  }
  
  /// 변경된 Context를 저장
  private func saveContext() {
    do {
      try viewContext.save()
    } catch {
      let error = error as NSError
      fatalError("Unresolved error \(error), \(error.userInfo)")
    }
  }
}

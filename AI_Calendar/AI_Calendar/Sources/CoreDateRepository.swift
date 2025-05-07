//
//  CoreDateRepository.swift
//  AI_Calendar
//
//  Created by 심근웅 on 5/7/25.
//

import Foundation
import CoreData

/// CoreData에 접근하는 Repository
final class CoreDateRepository {
  
  static let shared = CoreDateRepository()
  private let context = PersistenceController.shared.container.viewContext
  
  private init() { }
  
  /// 전체 Event를 불러옴
  func fetchAll() throws -> [Event] {
    let request: NSFetchRequest<Event> = Event.fetchRequest()
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Event.date, ascending: true)]
    return try context.fetch(request)
  }
  
  /// 새로운 일정 생성
  /// - Parameters:
  ///   - title: 일정 이름
  ///   - date: 일정 날짜
  ///   - memo: title, date를 제외한 일정에 필요한 내용
  public func addEvent(title: String, date: Date, memo: String? = nil) {
    let newEvent = Event(context: context)
    newEvent.id = UUID()
    newEvent.title = title
    newEvent.date = date
    newEvent.memo = memo
    
    PersistenceController.shared.save(context: context)
  }
  
  /// event를 받아서 해당 event를 삭제
  public func delete(_ event: Event) {
    context.delete(event)
    PersistenceController.shared.save(context: context)
  }
}


///// 여기도 추후 LLM으로도 수정하기 위해 변경필요
//public func updateEvent(_ event: Event, newTitle: String, newDate: Date, newMemo: String?) {
//  event.title = newTitle
//  event.date = newDate
//  event.memo = newMemo
//  
//  saveContext()
//  fetchEvents()
//}

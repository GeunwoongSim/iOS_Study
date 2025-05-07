//
//  AlanService.swift
//  AI_Calendar
//
//  Created by 심근웅 on 5/7/25.
//

import Foundation

struct ScheduleResponse: Codable {
  let Date: String
  let Action: String
  let Content: String
}

class AlanService {
  static let shared = AlanService()
  
  private let baseURL = "https://kdt-api-function.azurewebsites.net/api/v1/question"
  private let resetURL = "https://kdt-api-function.azurewebsites.net/api/v1/reset-state"
  private let clientID = ""
  
  func send(text: String) async throws -> [String] {
    let text = """
    당신은 캘린더 앱을 위한 AI 비서입니다.
    사용자가 일정 관련 명령을 입력하면, 반드시 세 가지 정보만 추출하여 **오직** JSON 객체로만 응답해야 합니다(추가 설명이나 마크다운 금지).
    
    1. "Date": ISO 8601 형식(YYYY-MM-DD 또는 YYYY-MM-DDTHH:MM:SS)으로 날짜 및 시간.
    - 사용자가 날짜/시간을 명시하지 않으면 빈 문자열("")로 설정하세요.
    - 사용자가 시간만 명시했다면 오늘날짜로 설정하세요.
    2. "Action": 다음 네 가지 문자열 중 하나로만 설정합니다.
    - Add
    - Remove
    - Edit
    - ETC   ← 그 외 모든 의도
    3. "Content": 사용자 입력에서 날짜와 Action을 제외한 나머지 텍스트(앞뒤 공백 제거).
    
    **규칙**
    - 다른 키나 텍스트를 포함하지 마세요.
    - 날짜/시간을 파싱할 수 없으면 `"Date": ""`로 설정합니다.
    - Date/Content만 있는 경우 `"Action: "Add"`로 설정합니다
    - 의도가 Add/Remove/Edit이 아니면 `"Action": "ETC"`로 설정합니다.
    - 항상 유효한 JSON을 반환해야 합니다.
    
    **예시**
    사용자: “내일 3시에 회의 추가해 줘”  
    AI 응답:
    ```json
    {
    "Date": "2025-05-08T15:00:00",
    "Action": "Add",
    "Content": "회의"
    }
    ```
    
    사용자 입력: “\(text)”
    """
    
    guard var components = URLComponents(string: baseURL) else {
      throw URLError(.badURL)
    }
    components.queryItems = [
      URLQueryItem(name: "content", value: text),
      URLQueryItem(name: "client_id", value: clientID)
    ]
    guard let url = components.url else {
      throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let (data, _) = try await URLSession.shared.data(for: request)

    guard
      let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
      let reply = json["content"] as? String
    else {
      return []
    }
    
    let str = stripCodeFence(from: reply)
    print(str)
    
    if let arr = parseToArray(from: str) {
      return arr
    }
    
    return []
  }
  
  func parseToArray(from jsonString: String) -> [String]? {
    guard let data = jsonString.data(using: .utf8) else { return nil }
    do {
      let decoded = try JSONDecoder().decode(ScheduleResponse.self, from: data)
      return [decoded.Date, decoded.Action, decoded.Content]
    } catch {
      print("Decoding error:", error)
      return nil
    }
  }
  
  func stripCodeFence(from raw: String) -> String {
    var s = raw
    
    // 1) 앞의 ```json 과 개행 제거
    if let range = s.range(of: "```json") {
      s.removeSubrange(range)
    }
    // 2) 뒤의 ``` 제거
    if let range = s.range(of: "```", options: .backwards) {
      s.removeSubrange(range)
    }
    // 3) 앞뒤 공백·개행 정리
    return s.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

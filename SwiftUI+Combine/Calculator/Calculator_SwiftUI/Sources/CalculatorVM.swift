//
//  CalculatorVM.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/26/25.
//

import Foundation
import Combine

final class CalculatorVM: ObservableObject {
  @Published var preExpress: String = "" // "="를 터치시 결과 위에 계산식을 보여줌
  @Published var displayStr: String = "0" // 화면에 보여지는 Str
  @Published var onAC: Bool = true // AC를 보여줄지 한개 지우기를 보여줄지
  
  // type이 .num이면 number사용, .oper면 value사용
  struct data {
    let type: BtnType
    var number: String?
    let value: BtnValue?
  }
  private var stack: [data] = []
  var topValue: BtnValue? { return stack.last?.value } // 가장위 value의 정보만 공개
  
  enum action {
    case numBtnTouch(value: String)
    case operBtnTouch(value: BtnValue)
    case equalBtnTouch
    case clearBtnTouch
  }

  func send(_ action: action) {
    switch action {
    case .numBtnTouch(let value):
      onAC = false
      preExpress = ""
      if let top = stack.last, top.type == .num { // 이전 입력된 숫자가 있음
        // 이전에 입려되있던 숫자가 0이 아니면 그 숫자에 새로운 숫자를 이어 붙임
        let num = (top.number! == "0" ? value : top.number! + value)
        stack.removeLast()
        stack.append(data(type: .num, number: num, value: nil))
      }else { // 이전 입력값이 없거나 연산자가 들어와 있음
        stack.append(data(type: .num, number: value, value: nil))
      }
      
    case .operBtnTouch(let value):
      onAC = false
      preExpress = ""
      if let top = stack.last {
        if top.type == .num { // 이전 입력이 숫자임
          stack.append(data(type: .oper, number: nil, value: value))
        }else if top.type == .oper { // 이전 입력이 연산자임
          if value.rawValue == "-" && top.value != .sum && top.value != .sub {
            // 현재 입력이 - 이면서 이전 입력이 +, -가 아님
            stack.append(data(type: .oper, number: nil, value: value))
          }else { // 다른 상황의 경우 기존에 있던 연산자는 전부 제거하고 입력
            while !stack.isEmpty && stack.last?.type != .num {
              stack.removeLast()
            }
            stack.append(data(type: .oper, number: nil, value: value))
          }
        }
      }else { // 이전 입력이 없음
        if value.rawValue != "-" { // +, *, /는 앞에 0을 넣어줌, -는 음수 가능
          stack.append(data(type: .num, number: "0", value: nil))
        }
        stack.append(data(type: .oper, number: nil, value: value))
      }
      
    case .equalBtnTouch:
      if stack.count > 2 { //계산식은 3자리 이상일때만 작동(단항식은 = 이 필요없기 때문)
        onAC = true
        // 연산자가 맨뒤에 붙은 경우, 연산자를 전부 제거
        while !stack.isEmpty && stack.last?.type != .num {
          stack.removeLast()
        }
        preExpress = displayStr
        calculate(expressionUpdate(isDisplay: false))
      }
      
    case .clearBtnTouch:
      preExpress = ""
      if onAC {
        stack.removeAll()
      }
      else {
        let top = stack.removeLast()
        if var num = top.number {
          num.removeLast()
          if num != "" {
            stack.append(data(type: .num, number: num, value: nil))
          }
        }
      }
    }
    // 화면에 계산식 표현
    displayStr = expressionUpdate(isDisplay: true)
  }
}

// MARK: private func
extension CalculatorVM {
  // 스택에 담겨있는 정보를 계산식으로 바꿔줌(표현용인지, 계산용인지 구분)
  private func expressionUpdate(isDisplay: Bool) -> String {
    if stack.isEmpty {
      onAC = true
      return "0"
    }
    var str: String = ""
    for s in stack {
      switch s.type {
      case .num: str += s.number!
      case .oper: str += (isDisplay ? s.value!.express : s.value!.rawValue)
      case .etc: continue
      }
    }
    return str
  }
  
  private func calculate(_ expression: String) {
    // NSExpresstion을 사용해 계산식을 계산
    let expression = NSExpression(format: expression)
    stack.removeAll()
    guard let result = expression.expressionValue(with: nil, context: nil) as? NSNumber else {
      displayStr = "계산식 오류"
      return
    }
    // 최종 계산 결과를 스택에 저장
    stack.append(data(type: .num, number: result.stringValue, value: nil))
  }
}

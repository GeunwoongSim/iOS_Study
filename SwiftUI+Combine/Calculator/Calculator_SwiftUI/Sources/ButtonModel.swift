//
//  CalculateButton.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/26/25.
//

import Foundation

enum BtnType {
  case num
  case oper
  case etc
}

enum BtnValue: String {
  // 숫자
  case zero = "0"
  case one = "1"
  case two = "2"
  case three = "3"
  case four = "4"
  case five = "5"
  case six = "6"
  case seven = "7"
  case eight = "8"
  case nine = "9"
  // 기초연산자
  case sum = "+"
  case sub = "-"
  case mul = "*"
  case div = "/"
  // 그외 기능
  case equal = "="
  case clear = "AC"
  
  // 겉으로 보이는 값
  var express: String {
    switch self {
    case .sum: return "+"
    case .sub: return "-"
    case .mul: return "✕"
    case .div: return "÷"
    case _: return self.rawValue
    }
  }
}


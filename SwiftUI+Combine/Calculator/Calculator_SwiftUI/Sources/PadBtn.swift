//
//  PadBtn.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/26/25.
//

import SwiftUI

struct PadBtn: View {
  @EnvironmentObject var viewModel: CalculatorVM
  
  private let type: BtnType
  private let value: BtnValue
  
  init(type: BtnType, value: BtnValue) {
    self.type = type
    self.value = value
  }

  var body: some View {
    let length: CGFloat = (UIScreen.main.bounds.width - 50) / 4
    Text(expressName())
      .animation(nil)
      .frame(width: length, height: length)
      .bold()
      .background(backColor())
      .cornerRadius(length/2)
      .foregroundStyle(.white)
      .font(.title)
      .onTapGesture {
        btnTouch()
      }
      .onLongPressGesture {
        viewModel.onAC = true
        viewModel.send(.clearBtnTouch)
      }
      .disabled(btnDisable())
  }
}

// MARK: private func
extension PadBtn {
  private func expressName() -> String {
    if value == .clear && viewModel.onAC { return "AC" }
    else if value == .clear && !viewModel.onAC { return "<=" }
    else { return value.express }
  }
  
  private func btnDisable() -> Bool {
    if value == .zero && viewModel.topValue == .div { return true }
    return false
  }
  
  private func btnTouch() {
    switch type {
    case .num:
      viewModel.send(.numBtnTouch(value: value.rawValue))
    case .oper:
      viewModel.send(.operBtnTouch(value: value))
    case .etc:
      if value == .clear {
        viewModel.send(.clearBtnTouch)
      }else if value == .equal {
        viewModel.send(.equalBtnTouch)
      }
    }
  }
  
  private func backColor() -> Color {
    var color: Color = .gray
    switch type {
    case .num: color = Color(uiColor: UIColor.darkGray)
    case .oper: color = .orange
    case .etc: color = Color(uiColor: UIColor.lightGray)
    }
    return color
  }
}

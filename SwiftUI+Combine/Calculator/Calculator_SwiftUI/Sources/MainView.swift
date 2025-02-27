//
//  MainView.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/26/25.
//

import SwiftUI

struct MainView: View {
  @StateObject var viewModel: CalculatorVM = CalculatorVM()
  
  var body: some View {
    VStack {
      Spacer()
      PreResultUI()
      ResultUI()
      PadUI()
    }
    .preferredColorScheme(.dark)
    .environmentObject(viewModel)
  }
}

// MARK: 이전 결과값 보여주는 화면
fileprivate struct PreResultUI: View {
  @EnvironmentObject var viewModel: CalculatorVM
  
  var body: some View {
    ScrollView(.horizontal) {
      Text(viewModel.preExpress)
        .foregroundStyle(Color(uiColor: UIColor.lightGray))
        .font(Font.system(size: 30))
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 8)
    .scrollIndicators(.hidden)
    .defaultScrollAnchor(.trailing)
  }
}

// MARK: 결과값 보여주는 화면 (specifier를 쓰면 자릿수 표현 가능)
fileprivate struct ResultUI: View {
  @EnvironmentObject var viewModel: CalculatorVM
  
  var body: some View {
    ScrollView(.horizontal) {
      Text(viewModel.displayStr)
        .foregroundStyle(.white)
        .font(Font.system(size: 70))
        .bold()
    }
    .padding(.horizontal, 16)
    .scrollIndicators(.hidden)
    .defaultScrollAnchor(.trailing)
  }
}

// MARK: 숫자 패드 화면
fileprivate struct PadUI: View {
  var body: some View {
    VStack {
      HStack {
        PadBtn(type: .num, value: .seven)
        PadBtn(type: .num, value: .eight)
        PadBtn(type: .num, value: .nine)
        PadBtn(type: .oper, value: .div)
      }
      HStack {
        PadBtn(type: .num, value: .four)
        PadBtn(type: .num, value: .five)
        PadBtn(type: .num, value: .six)
        PadBtn(type: .oper, value: .mul)
      }
      HStack {
        PadBtn(type: .num, value: .one)
        PadBtn(type: .num, value: .two)
        PadBtn(type: .num, value: .three)
        PadBtn(type: .oper, value: .sub)
      }
      HStack {
        PadBtn(type: .etc, value: .clear)
        PadBtn(type: .num, value: .zero)
        PadBtn(type: .etc, value: .equal)
        PadBtn(type: .oper, value: .sum)
      }
    }.padding(.bottom, 72)
  }
}

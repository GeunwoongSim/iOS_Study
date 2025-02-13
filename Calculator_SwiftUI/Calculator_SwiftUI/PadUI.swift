//
//  PadUI.swift
//  Calculator_SwiftUI
//
//  Created by 심근웅 on 2/13/25.
//

import Foundation
import SwiftUI

struct PadUI: View {
    @EnvironmentObject var calculator: Calculator
    var body: some View {
        VStack{
            HStack{
                PadBtn(info: ButtonModel(name: "AC", type: .Etc))
                PadBtn(info: ButtonModel(name: "+/-", type: .Etc))
                PadBtn(info: ButtonModel(name: "%", type: .Etc))
                PadBtn(info: ButtonModel(name: "÷", type: .BasicOperation))
            }
            HStack{
                PadBtn(info: ButtonModel(name: "7", type: .Number))
                PadBtn(info: ButtonModel(name: "8", type: .Number))
                PadBtn(info: ButtonModel(name: "9", type: .Number))
                PadBtn(info: ButtonModel(name: "✕", type: .BasicOperation))
            }
            HStack{
                PadBtn(info: ButtonModel(name: "4", type: .Number))
                PadBtn(info: ButtonModel(name: "5", type: .Number))
                PadBtn(info: ButtonModel(name: "6", type: .Number))
                PadBtn(info: ButtonModel(name: "-", type: .BasicOperation))
            }
            HStack{
                PadBtn(info: ButtonModel(name: "1", type: .Number))
                PadBtn(info: ButtonModel(name: "2", type: .Number))
                PadBtn(info: ButtonModel(name: "3", type: .Number))
                PadBtn(info: ButtonModel(name: "+", type: .BasicOperation))
            }
            HStack{
                PadBtn(info: ButtonModel(name: "0", type: .Zero))
                PadBtn(info: ButtonModel(name: ".", type: .Number))
                PadBtn(info: ButtonModel(name: "=", type: .BasicOperation))
            }
        }
    }
    
}

#Preview {
    PadUI().environmentObject(Calculator())
}

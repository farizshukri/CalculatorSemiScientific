//
//  ContentView.swift
//  ScientificCalculator
//
//  Created by FarizShukri  on 18/07/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = CalculatorModel()
    
    let buttons: [[String]] = [
        ["Del/AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "=", "√"],
        ["sin", "cos", "tan", "x²"]
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            HStack {
                Spacer()
                Text(model.display)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.black)
            .cornerRadius(12)
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            if button == "Del/AC" {
                                // Do nothing here, handled below
                            } else if button == "=" || button == "+" || button == "-" || button == "×" || button == "÷" || button == "√" || button == "x²" || button == "sin" || button == "cos" || button == "tan" {
                                model.performOperation(button)
                            } else {
                                model.input(button)
                            }
                        }) {
                            Text(button == "Del/AC" ? "Del" : button)
                                .font(.largeTitle)
                                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .cornerRadius(self.buttonHeight() / 2)
                                .gesture(
                                    LongPressGesture(minimumDuration: 1)
                                        .onEnded { _ in
                                            if button == "Del/AC" {
                                                model.performOperation("AC")
                                            }
                                        }
                                )
                                .simultaneousGesture(
                                    TapGesture()
                                        .onEnded {
                                            if button == "Del/AC" {
                                                model.deleteLast()
                                            }
                                        }
                                )
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.black)
    }
    
    private func buttonWidth(button: String) -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

@main
struct ScientificCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


//
//  ScientificCalculator_1stApp.swift
//  ScientificCalculator-1st
//
//  Created by FarizShukri  on 18/07/2024.
//

import Foundation

class CalculatorModel: ObservableObject {
    @Published var display = "0"
    private var currentNumber: Double = 0
    private var currentOperation: String? = nil
    private var previousNumber: Double = 0

    func input(_ value: String) {
        if currentOperation == nil {
            display = (display == "0") ? value : display + value
            currentNumber = Double(display) ?? 0
        } else {
            if currentNumber == previousNumber {
                display = value
            } else {
                display += value
            }
            currentNumber = Double(display) ?? 0
        }
    }

    func performOperation(_ operation: String) {
        switch operation {
        case "AC":
            display = "0"
            currentNumber = 0
            previousNumber = 0
            currentOperation = nil
        case "=":
            if let currentOperation = currentOperation {
                switch currentOperation {
                case "+":
                    currentNumber = previousNumber + currentNumber
                case "-":
                    currentNumber = previousNumber - currentNumber
                case "×":
                    currentNumber = previousNumber * currentNumber
                case "÷":
                    currentNumber = previousNumber / currentNumber
                default:
                    break
                }
                display = "\(currentNumber)"
                self.currentOperation = nil
            }
        case "sin":
            currentNumber = sin(currentNumber)
            display = "\(currentNumber)"
        case "cos":
            currentNumber = cos(currentNumber)
            display = "\(currentNumber)"
        case "tan":
            currentNumber = tan(currentNumber)
            display = "\(currentNumber)"
        case "√":
            currentNumber = sqrt(currentNumber)
            display = "\(currentNumber)"
        case "x²":
            currentNumber = pow(currentNumber, 2)
            display = "\(currentNumber)"
        default:
            previousNumber = currentNumber
            currentOperation = operation
        }
    }

    func deleteLast() {
        guard !display.isEmpty else { return }
        display.removeLast()
        if display.isEmpty || display == "-" {
            display = "0"
        }
        currentNumber = Double(display) ?? 0
    }
}

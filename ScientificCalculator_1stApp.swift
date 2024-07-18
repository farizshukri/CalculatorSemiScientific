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
        if operation == "AC" {
            display = "0"
            currentNumber = 0
            previousNumber = 0
            currentOperation = nil
        } else if operation == "=" {
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
        } else {
            previousNumber = currentNumber
            currentOperation = operation
        }
    }
}


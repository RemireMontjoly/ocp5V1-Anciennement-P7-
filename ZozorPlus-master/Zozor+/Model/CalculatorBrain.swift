//
//  CalculatorBrain.swift
//  CountOnMe
//
//  Created by pith on 20/03/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    enum SyntaxError: Error {
        case operatorBeforeNumber
        case equalAfterOperator
    }
    
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {  
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    func addPlusOperator() throws {
        if let stringNumber = stringNumbers.last,
            stringNumber.isEmpty {
            throw SyntaxError.operatorBeforeNumber
        }
        operators.append("+")
        stringNumbers.append("")
    }
    
    func addMinusOperator() throws {
        if let stringNumber = stringNumbers.last,
            stringNumber.isEmpty {
            throw SyntaxError.operatorBeforeNumber
        }
        operators.append("-")
        stringNumbers.append("")
    }
    
    func calculateTotal() throws -> Int {
        if let stringNumber = stringNumbers.last,
            stringNumber.isEmpty,
            stringNumbers.count == 1 {
            throw SyntaxError.equalAfterOperator
        }
        if let stringNumber = stringNumbers.last,
            stringNumber.isEmpty {
            throw SyntaxError.operatorBeforeNumber
        }
        var total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        return total
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    
}


//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class Zozor_Tests: XCTestCase {

    var brain: CalculatorBrain!

    override func setUp() {
        super.setUp()
        brain = CalculatorBrain()
    }

    // MARK: - test func addNewNumber()
    func testGivenEmptyStringInNumbersArray_WhenAddNewNumber_ThenNumberIsAddedAtTheLastIndex() {

        brain.addNewNumber(3)
        brain.addNewNumber(7)

        XCTAssertEqual(brain.stringNumbers.last, "37")
    }
    // MARK: - test: func addPlusOperator()  *****************************
    // Throwing error
    func testGivenNoNumberTapped_WhenAddPlusOperator_ThenThrowError() {

        XCTAssertThrowsError(try brain.addPlusOperator()) { error in
            XCTAssertTrue(error is CalculatorBrain.SyntaxError)
            XCTAssertEqual(error as! CalculatorBrain.SyntaxError , .operatorBeforeNumber)
        }
    }
    // Not throwing error
    func testGivenNumberIsTapped_WhenAddPlusOperator_ThenAddOperatorAndAddEmptyStringToTheirArray() {

        brain.addNewNumber(4)

        XCTAssertNoThrow(try brain.addPlusOperator(), "No Error!")
    }

    // MARK: - test:func addMinusOperator()  *****************************************
    // Throwing error
    func testGivenNoNumberTapped_WhenAddMinusOperator_ThenThrowError() {

        XCTAssertThrowsError(try brain.addMinusOperator()) { error in
            XCTAssertTrue(error is CalculatorBrain.SyntaxError)
            XCTAssertEqual(error as! CalculatorBrain.SyntaxError , .operatorBeforeNumber)
        }
    }
    // Not throwing error
    func testGivenNumberIsTapped_WhenAddMinusOperator_ThenAddOperatorAndEmptyStringToTheirArray() {

        brain.addNewNumber(4)

        XCTAssertNoThrow(try brain.addMinusOperator(), "No Error!")
    }

    func testGivenCalculationIsFinished_WhenEqualIsTapped_ThenResetArrays() {
        brain.stringNumbers.append("3")
        brain.operators.append("-")

        brain.clear()

        XCTAssertEqual(brain.stringNumbers, [String()])
        XCTAssertEqual(brain.operators, ["+"])
    }

    // MARK: - test: func calculateTotal
    // 1. Throwing error: noExpression
    func testGivenNoExpressionOnScreen_WhenCalculateTotal_ThenThrowError() {

        XCTAssertThrowsError(try brain.calculateTotal()) { error in
            XCTAssertTrue(error is CalculatorBrain.SyntaxError)
            XCTAssertEqual(error as! CalculatorBrain.SyntaxError, .noExpression)
        }
    }
    // 2. Throwing error: expressionIncorrect
    func testGivenOperatorOnScreen_WhenCalculateTotal_ThenThrowError() {
        brain.addNewNumber(3)
        XCTAssertNoThrow(try brain.addMinusOperator(), "No Error!")

        XCTAssertThrowsError(try brain.calculateTotal()) { error in
            XCTAssertTrue(error is CalculatorBrain.SyntaxError)
            XCTAssertEqual(error as! CalculatorBrain.SyntaxError, .expressionIncorrect)
        }
    }
    // 3. return total
    func testGivenACorrectExpression_WhenCalculateTotal_ThenReturnResult() {
        brain.addNewNumber(4)
        XCTAssertNoThrow(try brain.addMinusOperator(), "No Error!")
        brain.addNewNumber(3)

        XCTAssertEqual(try brain.calculateTotal(), 1)

    }

}
    


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
    override func tearDown() {
        brain = nil
        super.tearDown()
    }

    func createRandomNumber() -> Int {
        let randomNumber = Int.random(in: 0 ... 10)
        return randomNumber
    }
    // MARK: - test func addNewNumber()
    func testGivenEmptyStringInNumbersArray_WhenAddNewNumber_ThenNumberIsAddedAtTheLastIndex() {

        let number = createRandomNumber()
        let stringNumber = String(number)

        brain.addNewNumber(number)

        XCTAssertEqual(brain.stringNumbers.last, stringNumber)
    }
    // MARK: - test: func addPlusOperator() - FIRST version *****************************
    // Throwing error
    func testAddPlusOperatorThatThrowsError() {

        XCTAssertThrowsError(try brain.addPlusOperator()) {
            error in XCTAssertEqual(error as! CalculatorBrain.SyntaxError , .operatorBeforeNumber)
        }
    }
    // Not throwing error
    func testAddPlusOperatorThatDoesntThrowError() {

        brain.addNewNumber(createRandomNumber())

        XCTAssertNoThrow(try brain.addPlusOperator(), "No Error!")
    }
    // MARK: - Second version ***************************************************
    // Throwing error
    func testGivenNoNumberTapped_WhenAddPlusOperator_ThenThrowError() {

        do {
            let _ = try brain.addPlusOperator()

        } catch let error as CalculatorBrain.SyntaxError {
            XCTAssertEqual(error, CalculatorBrain.SyntaxError.operatorBeforeNumber)
        } catch {
            XCTFail("Unidentififed error thrown: \(error.localizedDescription)")
        }
    }
    // Not throwing error
    func testGivenNumberIsTapped_WhenAddPlusOperator_ThenAddOperatorAndAddEmptyStringToTheirArray() {

        brain.addNewNumber(createRandomNumber())

        do {
            try brain.addPlusOperator()
            XCTAssertEqual(brain.stringNumbers.last, "")
            XCTAssertEqual(brain.operators.last, "+")
        } catch {
            XCTFail("Unidentififed error thrown: \(error.localizedDescription)")
        }
    }
    // MARK: - test:func addMinusOperator()  *****************************************
    // Throwing error
    func testAddMinusOperatorThatThrowsError() {

        XCTAssertThrowsError(try brain.addMinusOperator()) {
            error in XCTAssertEqual(error as! CalculatorBrain.SyntaxError , .operatorBeforeNumber)
        }
    }
    // Not throwing error
    func testAddMinusOperatorThatDoesntThrowError() {

        brain.addNewNumber(createRandomNumber())

        XCTAssertNoThrow(try brain.addMinusOperator(), "No Error!")
    }

    func testGivenCalculationIsFinished_WhenEqualIsTapped_ThenResetArrays() {
        brain.stringNumbers += ["1"]
        brain.operators += ["-"]

        brain.clear()

        XCTAssertEqual(brain.stringNumbers, [String()])
        XCTAssertEqual(brain.operators, ["+"])
    }

    func testGivenAnExpression_WhenCalculateTotal_ThenReturnResult() {
        // 1/ throw SyntaxError.noExpression
        // 2/ throw SyntaxError.expressionIncorrect
        // 3/ total += if ...
        // 4/ total -= if ...
    }

}
    


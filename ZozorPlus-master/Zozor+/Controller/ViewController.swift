//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    private var brain = CalculatorBrain()

    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // MARK: - Action
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                brain.addNewNumber(i)
                updateDisplay()
            }
        }
    }
    
    @IBAction func plus() {
        do {
            try brain.addPlusOperator()
            updateDisplay()
        } catch CalculatorBrain.SyntaxError.operatorBeforeNumber {
            Alert.showAlert(title: "Zéro", message: "Expression incorrecte !", vc: self)
        } catch {
            Alert.showAlert(title: "Zéro", message: error.localizedDescription , vc: self)
        }
    }
    
    @IBAction func minus() {
        do {
            try brain.addMinusOperator()
            updateDisplay()
        } catch CalculatorBrain.SyntaxError.operatorBeforeNumber {
            Alert.showAlert(title: "Zéro", message: "Expression incorrecte !", vc: self)
        } catch {
            Alert.showAlert(title: "Zéro", message: error.localizedDescription, vc: self)
        }
    }
    
    @IBAction func equal() {
        do {
            let total = try brain.calculateTotal()
            textView.text = textView.text + "=\(total)"
            brain.clear()
        } catch CalculatorBrain.SyntaxError.expressionIncorrect {
            Alert.showAlert(title: "Zéro!", message: "Entrez une expression correcte !", vc: self)
        } catch CalculatorBrain.SyntaxError.noExpression {
            Alert.showAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !", vc: self)
        } catch {
            Alert.showAlert(title: "Zéro", message: error.localizedDescription, vc: self)
        }
    }

    @IBAction func clearScreen(_ sender: UIButton) {
        brain.clear()
        textView.text = ""
    }
    
    
    // MARK: - Methods
    
    func updateDisplay() {
        var text = ""
        for (i, stringNumber) in brain.stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += brain.operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }
}

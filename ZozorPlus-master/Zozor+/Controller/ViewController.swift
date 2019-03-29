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
    
    enum PopUpAlertError: Error {
        case addOperatorBeforeNumber
        // case addEqualBeforeNumber
        case addEqualAfterOperator
    }
    
    private var brain = CalculatorBrain()
//    var isExpressionCorrect: Bool {
//        if let stringNumber = brain.stringNumbers.last {
//            if stringNumber.isEmpty {
//                if brain.stringNumbers.count == 1 {
//                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
//                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self.present(alertVC, animated: true, completion: nil)
//                } else {
//                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
//                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self.present(alertVC, animated: true, completion: nil)
//                }
//                return false
//            }
//        }
//        return true
//    }
    //     var canAddOperator: Bool {
    //        if let stringNumber = brain.stringNumbers.last {
    //            if stringNumber.isEmpty {
    //                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
    //                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    //                self.present(alertVC, animated: true, completion: nil)
    //                return false
    //            }
    //        }
    //        return true
    //    }
    
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
    
    func checkCorrectInput() throws {
        let stringNumber = brain.stringNumbers.last!
        if stringNumber.isEmpty && brain.stringNumbers.count == 1 {
            throw PopUpAlertError.addEqualAfterOperator
        }
        if stringNumber.isEmpty {
            throw PopUpAlertError.addOperatorBeforeNumber
        }
    }
    
    @IBAction func plus() {
        do {
            try checkCorrectInput()
        } catch PopUpAlertError.addOperatorBeforeNumber {
            Alert.showAlert(title: "Zéro", message: "Expression incorrecte !", vc: self)
            return
        }
        catch {
            print("AnyOther error")
        }
        brain.addPlusOperator()
        updateDisplay()
    }
    
    @IBAction func minus() {
        do {
            try checkCorrectInput()
        } catch PopUpAlertError.addOperatorBeforeNumber {
            Alert.showAlert(title: "Zéro", message: "Expression incorrecte !", vc: self)
            return
        }
        catch {
            print("AnyOther error")
        }
        brain.addMinusOperator()
        updateDisplay()
    }
    
    @IBAction func equal() {
        calculateTotal()
    }
    
    // MARK: - Methods
    
    func calculateTotal() {
        do {
            try checkCorrectInput()
        } catch PopUpAlertError.addOperatorBeforeNumber {
            Alert.showAlert(title: "Zéro!", message: "Entrez une expression correcte !", vc: self)
            return
        } catch PopUpAlertError.addEqualAfterOperator {
            Alert.showAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !", vc: self)
            return
        }       catch {
            print("AnyOther error")
        }
        //        if !isExpressionCorrect {
        //            return
        //        }
        let total = brain.calculateTotal()
        textView.text = textView.text + "=\(total)"
        brain.clear()
    }
    
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

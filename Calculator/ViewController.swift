//
//  ViewController.swift
//  Calculator
//
//  Created by maxim mironov on 11/08/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//



import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLable: UILabel!
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: OperationEnum = OperationEnum.none
    var calculator = Calculator()
    var currentInput: Double {
        get{
            return Double(displayResultLable.text!)!
        }
        set{
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            displayResultLable.text = (valueArray[1] == "0") ? "\(valueArray[0])" : value
            stillTyping = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func numerPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if !calculator.stillTyping {
            displayResultLable.text = number
            calculator.stillTyping = true
        }else{
             displayResultLable.text = displayResultLable.text! + number
        }
    }

    @IBAction func binaryOperandPressed(_ sender: UIButton) {
        
//        if OperationEnum(rawValue: sender.tag)! == OperationEnum.percent{
//            currentInput = calculator.calculate(secondOperand: currentInput, tag: sender.tag)
//        }
        
        if !calculator.stillTyping && calculator.operation == OperationEnum(rawValue: sender.tag)!{
            return
        }
        if calculator.operation != .none{
            currentInput = calculator.calculate(secondOperand: currentInput, tag: sender.tag)
        }
        calculator.setFirstOperand(tag: sender.tag, value: currentInput)
    }
    
    @IBAction func unaryOperandPressed(_ sender: UIButton) {
        calculator.operation = OperationEnum(rawValue: sender.tag)!
        currentInput = calculator.calculate(secondOperand: currentInput, tag: sender.tag)
    }
    
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if calculator.stillTyping{
            currentInput = calculator.calculate(secondOperand: currentInput, tag: sender.tag)
        }
    }
}


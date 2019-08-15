//
//  Calculator.swift
//  Calculator
//
//  Created by maxim mironov on 11/08/2019.
//  Copyright © 2019 maxim mironov. All rights reserved.
//

import Foundation
enum OperationEnum:Int{
    case
    none = -1,
    clear,
    plusMinus,
    percent,
    plus,
    minus,
    multiplication,
    division,
    sqrt
}
enum UnaryOperationEnum:Int{
   case clear = 0
   case plusMinus = 1
   case sqrt = 7
}
protocol CalculatorServiceProtocol{
    func calculate(nextoperand:Double,operationNumber:Int) -> Double
    var stillTyping:Bool { get set }
}
class Calculator:CalculatorServiceProtocol {
    
    var firstOperand:Double = 0.0
    var secondOperand:Double = 0.0
    var operation = OperationEnum.none
    var previouseOperation = OperationEnum.none
    var stillTyping = false
    
    func calculate(nextoperand:Double = 0.0,operationNumber:Int) -> Double{
        var nextoperand = nextoperand
        if let nextUnaryOperation = UnaryOperationEnum(rawValue: operationNumber){
            if nextUnaryOperation == .clear{
                setDefaultData()
                return 0
            }
            if previouseOperation != .none && !(UnaryOperationEnum(rawValue: previouseOperation.rawValue) != nil){
               nextoperand = calculateValue(nextOperand: nextoperand, nextOperation: previouseOperation)
            }
            operation = OperationEnum(rawValue: operationNumber)!
        }
        else if !stillTyping || operation == .none{
            firstOperand = nextoperand
            operation = OperationEnum(rawValue: operationNumber)!
            previouseOperation = operation
            stillTyping = false
            return nextoperand
        }
        let rval = calculateValue(nextOperand: nextoperand, nextOperation: operation)
        previouseOperation = operation
        operation = .none
        stillTyping = false
        return rval
        
    }
    
    private func operateWithTwoOperands(operation: (Double, Double) -> Double) -> Double{
        return operation(firstOperand,secondOperand)
    }
    
    private func calculateValue(nextOperand:Double,nextOperation:OperationEnum) -> Double{
        self.secondOperand = nextOperand
        var rval:Double = 0.0
        switch nextOperation {
        case .plus:
            rval = operateWithTwoOperands{$0+$1}
        case .minus:
            rval = operateWithTwoOperands{$0-$1}
        case .multiplication:
           rval =  operateWithTwoOperands{$0*$1}
        case .division:
            rval = operateWithTwoOperands{$0/$1}
        case .plusMinus:
           rval =  operateWithTwoOperands{0 - $1}
        case .sqrt:
            rval = (secondOperand > 0) ? operateWithTwoOperands{0 + sqrt($1)} : secondOperand
        case .percent:
           rval =  operateWithTwoOperands{$0*$1/100}
        default:
            rval = 0.0
        }
        return rval
    }
    private func setDefaultData(){
        firstOperand = 0.0
        secondOperand = 0.0
        operation = .none
    }
}

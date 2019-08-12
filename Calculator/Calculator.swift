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
   case percent = 2
}
class Calculator {
  //  var rval :Double = 0.0
    var firstOperand:Double = 0.0
    var secondOperand:Double = 0.0
    var operation = OperationEnum.none
    var previouseOperation = OperationEnum.none
    var stillTyping = false
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) -> Double{
        return operation(firstOperand,secondOperand)
    }

    
    func setFirstOperand(tag:Int,value:Double){
        self.firstOperand = value
        operation = OperationEnum(rawValue: tag)!
        stillTyping = false
    }
    
    func calculate(secondOperand:Double = 0.0,tag:Int) -> Double{
        var rval = 0.0
        if UnaryOperationEnum(rawValue: tag) == UnaryOperationEnum.percent{
            self.secondOperand = firstOperand/100 * secondOperand
            rval = calculateValue(secondOperand: self.secondOperand)
        }
        else{
            rval = calculateValue(secondOperand: secondOperand)
        }
        previouseOperation = operation
        operation = .none
        stillTyping = false
        return rval
    }
    
    private func calculateValue(secondOperand:Double) -> Double{
        self.secondOperand = secondOperand
        var rval:Double = 0.0
        switch operation {
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
           rval =  operateWithTwoOperands{0 + sqrt($1)}
        case .percent:
           rval =  operateWithTwoOperands{$0*$1/100}
        default:
            rval = 0.0
        }
        return rval
    }
}

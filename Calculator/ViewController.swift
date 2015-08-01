//
//  ViewController.swift
//  Calculator
//
//  Created by Souvik Banerjee on 7/31/15.
//  Copyright (c) 2015 Souvik Banerjee. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    var currentExpression = ""
    var currentNumber = ""
    @IBOutlet weak var mainLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        currentExpression += sender.currentTitle!
        println(currentExpression)
        if NSNumberFormatter().numberFromString(sender.currentTitle!) != nil || sender.currentTitle == "-" || sender.currentTitle == "."
        {
            currentNumber += sender.currentTitle!
            mainLabel.text = currentNumber
        }
        else
        {
            currentNumber = ""
        }
        
        
    }
    func evaluate(expression: String) -> Double?
    {
        func apply(operation: String, arg1: Double, arg2: Double) -> Double?
        {
            switch operation
            {
            case "/":
                if arg2 == 0
                {
                    return nil
                }
                return arg1/arg2
            case "*":
                return arg1*arg2
            case "–":
                return arg1-arg2
            case "+":
                return arg1+arg2
            default:
                return nil
            }
        }
        func convert(num: String) -> Double?
        {
            var negativeFlag = false
            if num == ""
            {
                return nil
            }
            var str = num as NSString
            if str.substringWithRange(NSRange(location: 0, length: 1)) == "-"
            {
                negativeFlag = true
                str = str.substringWithRange(NSRange(location: 1, length: str.length-1))
            }
            var validCharacters:[Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
            for character in str as String
            {
                if !contains(validCharacters, character)
                {
                    return nil
                }
            }
            return negativeFlag ? -str.doubleValue : str.doubleValue
        }
        var cursor = 0
        var stack: [Double] = []
        var currentNumberStr = ""
        var lastOperation = ""
        var operators:[Character] = ["/", "*", "–", "+"]
        for character in expression
        {
            if contains(operators, character)
            {
                
                var convertedNumber = convert(currentNumberStr)
                if convertedNumber == nil
                {
                    return nil
                }
                stack += [convertedNumber!]
                currentNumberStr = ""
                if lastOperation != ""
                {
                    if stack.count < 2
                    {
                        return nil
                    }
                    var result = apply(lastOperation, stack[stack.count-2], stack[stack.count-1])
                    if result == nil
                    {
                        return nil
                    }
                    stack[stack.count-2] = result!
                    stack.removeLast()
                }
                
                lastOperation = String(character)
            }
            else
            {
                currentNumberStr += String(character)
            }
            
        }
        if currentNumberStr == ""
        {
            return nil
        }
        var convertedNumber = convert(currentNumberStr)
        if convertedNumber == nil
        {
            return nil
        }
        stack += [convertedNumber!]
        if lastOperation != ""
        {
            if stack.count < 2
            {
                return nil
            }
            var result = apply(lastOperation, stack[stack.count-2], stack[stack.count-1])
            if result == nil
            {
                return nil
            }
            stack[stack.count-2] = result!
            if stack.count != 2
            {
                return nil
            }
        }
        if stack.count == 0
        {
            return nil
        }
        return stack[0]
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            var result = evaluate(currentExpression)
            if result == nil
            {
                currentExpression = ""
                currentNumber = ""
                mainLabel.text = "Error"
            }
            else
            {
                currentExpression = ""
                currentNumber = ""
                mainLabel.text = "\(round(1E8*result!)/1E8)"
            }
        }
    }

}


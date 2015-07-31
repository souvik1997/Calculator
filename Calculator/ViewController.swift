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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(sender: UIButton) {
        currentExpression += sender.currentTitle!
        println(currentExpression)
        if NSNumberFormatter().numberFromString(sender.currentTitle!) != nil
        {
            currentNumber += sender.currentTitle!
            mainLabel.text = currentNumber
        }
        else
        {
            currentNumber = ""
        }
        
    }

}


//
//  ViewController.swift
//  Calculator
//
//  Created by Souvik Banerjee on 7/31/15.
//  Copyright (c) 2015 Souvik Banerjee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(sender: UIButton) {
        println("Button clicked: \(sender.currentTitle)")
    }

}


//
//  ViewController.swift
//  Super Simple Calculator
//
//  Created by Todd Resudek on 12/7/14.
//  Copyright (c) 2014 supersimple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentEquation = "0.0"
    var initialState = true
    var signedPositive = true
    var prefix = ""
    
    @IBOutlet weak var resultsLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func evaluate() {
        println(currentEquation)
        calculateResult(currentEquation)
        // evaluate the results so far
        currentEquation = ""
    }
    
    //parse the expression
    private func calculateResult(str: NSString){
        let exp = NSExpression(format:str)
        if let result:Double = NSExpression(format:str).expressionValueWithObject(nil, context: nil) as? Double {
            println(result)
        }else{
            resultsLabel.text = "error"
        }
    }

    
    
    
    @IBAction func buttonTapped(sender: AnyObject) {
        var buttonValue = sender.currentTitle
        // Clear value if it is in it's initial state
        if(initialState == true) {
            currentEquation = ""
            initialState = false
        }
        println(buttonValue)
        currentEquation += buttonValue!!
        resultsLabel.text = prefix + currentEquation
    }
    
    @IBAction func clearAll() {
        currentEquation = "0.0"
        initialState = true
        resultsLabel.text = prefix + currentEquation
    }
    
    @IBAction func insertDecimal(sender: AnyObject) {
        println(".")
        currentEquation += "."
        resultsLabel.text = prefix + currentEquation
    }
    
    @IBAction func multiplication() {
        println("x")
        currentEquation += "*"
        resultsLabel.text = prefix + currentEquation
    }

    @IBAction func subtraction() {
        println("-")
        currentEquation += "-"
        resultsLabel.text = prefix + currentEquation
    }
    
    @IBAction func addition() {
        println("+")
        currentEquation += "+"
        resultsLabel.text = prefix + currentEquation
    }
    
    @IBAction func division() {
        println("/")
        currentEquation += "/"
        resultsLabel.text = prefix + currentEquation
    }
    
    @IBAction func exponent() {
        //this needs to take 2 numbers
        var baseNum = 0
        var exp = 0
    }
    
    @IBAction func toggleSign() {
        if(signedPositive){
            signedPositive = false
            prefix = "-"
        }else{
            signedPositive = true
            prefix = ""
        }
        resultsLabel.text = prefix + currentEquation
    }
}


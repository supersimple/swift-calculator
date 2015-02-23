//
//  ViewController.swift
//  Super Simple Calculator
//
//  Created by Todd Resudek on 2/22/15.
//  Copyright (c) 2015 supersimple. All rights reserved.
//

// Known Bugs:
// after calculating an exponent, the lastCompleteNumber stays in front of the result.
// negative prefix does not work at beginning of equation
// negative number prefix always displays at the front (should be in front of next number - consider changing currentEquation to '(-1 * n)
// catch calculating errors

import UIKit

class ViewController: UIViewController {
    
    var currentEquation = "";
    var currentEquationAsString = "";
    var lastCompleteNumber = "";
    var exponentIsOpen = false;
    var exponentValue = "";
    var initialState = true;
    var signedPositive = true;
    var prefix = "";
    
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
        operatorCalled()
        let currentEquationModifier = "1.0 * "
        currentEquation += lastCompleteNumber;
        currentEquation = currentEquationModifier + currentEquation;
        var calculatedResult = "\(calculateResult(currentEquation))"
        resultsLabel.text = formatResult(calculatedResult);
        // evaluate the results so far
        currentEquation = ""
    }
    
    private func formatResult(result: NSString) -> NSString {
        
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter.stringFromNumber(result.doubleValue)!
        
    }
    
    //parse the expression
    private func calculateResult(str: NSString) -> Double {
        var result:Double = NSExpression(format: str).expressionValueWithObject(nil, context:nil) as Double;
        return result;
    }
    
    private func powerOf(base: NSNumber, exp: NSNumber) -> NSString{
        return String(format:"%f", pow(base.doubleValue, exp.doubleValue));
    }
    
    private func updateLastCompleteNumber(num: NSString) {
        //begin or append the lastCompleteNumber
        lastCompleteNumber += num
    }
    
    private func operatorCalled(){
        // this should move the lastCompleteNumber into the equation
        if(exponentIsOpen){ closeExponent() }
        
        currentEquation += lastCompleteNumber
        currentEquationAsString = currentEquation
        
        lastCompleteNumber = "";
    }
    
    private func closeExponent(){
        currentEquation += powerOf((lastCompleteNumber as NSString).floatValue,exp:(exponentValue as NSString).floatValue)
        currentEquationAsString += "^" + exponentValue
        resultsLabel.text = prefix + currentEquationAsString
        exponentValue = ""
        exponentIsOpen = false
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        var buttonValue = sender.currentTitle
        // Clear value if it is in it's initial state
        if(initialState == true) {
            currentEquation = ""
            currentEquationAsString = ""
            initialState = false
        }
        //check if the exponent is open. if so, the following number(s) are the exponent value
        if(exponentIsOpen){
            exponentValue += buttonValue!!
            currentEquationAsString += buttonValue!!
        }else{
            // this should keep the lastCompleteNumber apart from the currentEquation until an operator is called
            //currentEquation += buttonValue!!
            currentEquationAsString += buttonValue!!
            updateLastCompleteNumber(buttonValue!!)
        }
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func clearAll() {
        currentEquation = ""
        currentEquationAsString = "0"
        initialState = true
        lastCompleteNumber = ""
        exponentValue = ""
        prefix = ""
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func insertDecimal(sender: AnyObject) {
        currentEquation += "."
        currentEquationAsString = currentEquation
        updateLastCompleteNumber(".")
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func multiplication() {
        operatorCalled()
        currentEquation += "*"
        currentEquationAsString += "x"
        
        resultsLabel.text = prefix + currentEquationAsString
    }

    @IBAction func subtraction() {
        operatorCalled()
        currentEquation += "-"
        currentEquationAsString = currentEquation
        
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func addition() {
        operatorCalled()
        
        currentEquation += "+"
        currentEquationAsString = currentEquation
        
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func division() {
        operatorCalled()
        
        currentEquation += "/"
        currentEquationAsString += "÷"
        
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func exponent() {
        //this action should take 2 numbers
        //grab the most recent number
        //grab the next number for the exponent
        currentEquationAsString += "^"
        exponentIsOpen = true;
    }
    
    @IBAction func openParen() {
        if(!lastCompleteNumber.isEmpty){ currentEquation += "*" }
        currentEquation += "(";
        currentEquationAsString += "(";
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func closeParen() {
        currentEquation += ")"
        currentEquationAsString = currentEquation
        resultsLabel.text = prefix + currentEquationAsString
    }
    
    @IBAction func toggleSign() {
        if(signedPositive){
            signedPositive = false
            prefix = "-"
        }else{
            signedPositive = true
            prefix = ""
        }
        resultsLabel.text = prefix + currentEquationAsString
    }

}


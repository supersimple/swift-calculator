//
//  ViewController.swift
//  Super Simple Calculator
//
//  Created by Todd Resudek on 2/22/15.
//  Copyright (c) 2015 supersimple. All rights reserved.
//

// Known Bugs:
// catch calculating errors
// result directly to exponent causes error

import UIKit

class ViewController: UIViewController {
    
    var currentEquation = "";
    var currentEquationAsString = "";
    var lastCompleteNumber = "";
    var exponentIsOpen = false;
    var exponentValue = "";
    var operatorIsOpen = false;
    var initialState = true;
    var signedPositive = true;
    var prefix = "";
    let currentEquationModifier = "1.0 * "
    
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
        if(!operatorIsOpen){
            operatorCalled();
            operatorIsOpen = false;
            currentEquation = currentEquationModifier + currentEquation + lastCompleteNumber;
            var calculatedResult = "\(calculateResult(currentEquation))"
            currentEquation = "";
            
            var formatted_result = formatResult(calculatedResult);
            resultsLabel.text = formatted_result;
            currentEquationAsString = formatted_result;
            lastCompleteNumber = formatted_result;
            resetPrefix();
            signedPositive = true;
        }
    }
    
    private func resetPrefix(){
        prefix = "";
    }
    
    private func resetCurrentEquation(incString: Bool = false){
        currentEquation = "";
        if(incString){ currentEquationAsString = ""; }
    }
    
    private func setResultsLabel(val: NSString) {
        resultsLabel.text = val;
    }
    
    private func formatResult(result: NSString) -> NSString {
        
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.usesSignificantDigits = false;
        formatter.minimumSignificantDigits = 3;
        formatter.maximumSignificantDigits = 10;
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
        if(!operatorIsOpen){
            // this should move the lastCompleteNumber into the equation
            if(exponentIsOpen){ closeExponent() }
            operatorIsOpen = true;
            currentEquation += prefix + lastCompleteNumber
            currentEquationAsString = currentEquation
            
            resetPrefix();
            lastCompleteNumber = "";
        }
    }
    
    private func closeExponent(){
        currentEquation += powerOf((lastCompleteNumber as NSString).floatValue,exp:(exponentValue as NSString).floatValue)
        currentEquationAsString += "^" + exponentValue
        resultsLabel.text = prefix + currentEquationAsString
        exponentValue = ""
        exponentIsOpen = false
        lastCompleteNumber = "";
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        var buttonValue = sender.currentTitle
        // Clear value if it is in it's initial state
        if(initialState == true) {
            resetCurrentEquation(incString: true);
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
        setResultsLabel(prefix + currentEquationAsString);
        operatorIsOpen = false;
    }
    
    @IBAction func clearAll() {
        resetCurrentEquation(incString: false);
        currentEquationAsString = "0"
        initialState = true
        lastCompleteNumber = ""
        exponentValue = ""
        resetPrefix();
        setResultsLabel(prefix + currentEquationAsString);
    }
    
    @IBAction func insertDecimal(sender: AnyObject) {
        currentEquationAsString += "."
        updateLastCompleteNumber(".")
        setResultsLabel(prefix + currentEquationAsString);
    }
    
    @IBAction func multiplication() {
        if(!operatorIsOpen){
            operatorCalled()
            currentEquation += "*"
            currentEquationAsString += "*"
            
            setResultsLabel(prefix + currentEquationAsString);
        }
    }

    @IBAction func subtraction() {
        if(!operatorIsOpen){
            operatorCalled()
            currentEquation += "-"
            currentEquationAsString = currentEquation
            
            setResultsLabel(prefix + currentEquationAsString);
        }
    }
    
    @IBAction func addition() {
        if(!operatorIsOpen){
            operatorCalled()
            
            currentEquation += "+"
            currentEquationAsString = currentEquation
            
            setResultsLabel(prefix + currentEquationAsString);
        }
    }
    
    @IBAction func division() {
        if(!operatorIsOpen){
            operatorCalled()
        
            currentEquation += "/"
            currentEquationAsString += "/"
        
            setResultsLabel(prefix + currentEquationAsString);
        }
    }
    
    @IBAction func exponent() {
        currentEquationAsString += "^"
        exponentIsOpen = true;
    }
    
    @IBAction func openParen() {
        if(!lastCompleteNumber.isEmpty){ currentEquation += "*" }
        currentEquation += "(";
        currentEquationAsString += "(";
        setResultsLabel(prefix + currentEquationAsString);
    }
    
    @IBAction func closeParen() {
        currentEquation += ")"
        currentEquationAsString = currentEquation
        setResultsLabel(prefix + currentEquationAsString);
    }
    
    @IBAction func toggleSign() {
        
        if(signedPositive){
            signedPositive = false
            prefix = "-"
        }else{
            signedPositive = true
            resetPrefix();
        }
        //prefix should go before lastCompleteNumber, not always at the beginning of the entire equation
        currentEquation += prefix + lastCompleteNumber
        currentEquationAsString = currentEquation
        
        resetPrefix();
        setResultsLabel(currentEquationAsString);
    }

}


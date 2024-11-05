//
//  CalculatorModel.swift
//  BMI Calculator
//
//  Created by Muhamad Septian Nugraha on 05/11/24.
//

import UIKit

struct CalculatorModel {
    
    var bmi: BMI?
    
    mutating func calculateBMI(_ heightValue: Float, _ weightValue: Float) {
        let bmiValue = weightValue / pow(heightValue, 2)
        print(bmiValue)
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat some pies!", color: UIColor(named: "blueCustom")!)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: UIColor(named: "greenCustom")!)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: UIColor(named: "redCustom")!)
        }
        
    }
    
    func getBMIValue() -> String {
        let bmi = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmi
    }
    
    func getAdvice() -> String {
        let advice = bmi?.advice ?? " "
        return advice
    }
    
    func getColor() -> UIColor {
        let color = bmi?.color ?? UIColor.white
        return color
    }

}

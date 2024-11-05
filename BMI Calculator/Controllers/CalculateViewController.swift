//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Muhamad Septian Nugraha on 05/11/24.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var calculateModel = CalculatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        let height = String(format: "%.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        let weight = String(format: "%.0f", sender.value)
        weightLabel.text = "\(weight)Kg"
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        let heightValue = heightSlider.value
        let weightValue = weightSlider.value
        calculateModel.calculateBMI(heightValue, weightValue)
        
        // berpindah halaman ke result view controller
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.heightValue = Double(heightSlider.value)
            destinationVC.weightValue = Double(weightSlider.value)
            destinationVC.bmiValue = calculateModel.getBMIValue()
            destinationVC.bmiAdvice = calculateModel.getAdvice()
            destinationVC.bmiColor = calculateModel.getColor()
        }
    }
    
}


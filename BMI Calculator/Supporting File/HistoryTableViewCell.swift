//
//  HistoryTableViewCell.swift
//  BMI Calculator
//
//  Created by Muhamad Septian Nugraha on 05/11/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var heighAndWeightLabel: UILabel!
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

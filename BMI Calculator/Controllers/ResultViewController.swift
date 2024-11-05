//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Muhamad Septian Nugraha on 05/11/24.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiValue: String?
    var bmiAdvice: String?
    var bmiColor: UIColor?
    
    var heightValue: Double?
    var weightValue: Double?

    @IBOutlet weak var bmiResultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiResultLabel.text = bmiValue
        adviceLabel.text = bmiAdvice
        view.backgroundColor = bmiColor
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        saveData()
    }
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Saving Data ke CoreData
    func saveData() {
        
        // Buat instance entity
        let newItem = HistoryCalculate(context: context)
        newItem.weightValue = weightValue!
        newItem.heightValue = heightValue!
        newItem.resultValue = Double(bmiValue!)!
        newItem.timeStamp = Date()
        newItem.adviceValue = bmiAdvice ?? ""
        
        // Simpan context
        do {
            try context.save()
            print("Data berhasil disimpan.")
            
            // Tampilkan alert pemberitahuan pertama
            let alert = UIAlertController(title: "Berhasil", message: "Data berhasil disimpan.", preferredStyle: .alert)
            
            // Tambahkan aksi setelah tombol OK di klik
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                
                self.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
            
        } catch {
            print("Gagal menyimpan data: \(error)")
            
            // Tampilkan alert jika terjadi kesalahan
            let alert = UIAlertController(title: "Error", message: "Gagal menyimpan data.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                
                self.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
}

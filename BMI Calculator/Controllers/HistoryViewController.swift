//
//  HistoryViewController.swift
//  BMI Calculator
//
//  Created by Muhamad Septian Nugraha on 05/11/24.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var historyCalculate: [HistoryCalculate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        registerCell()
        fetchItems()
    }
    
    // MARK: - Register for Custom Table Cell
    func registerCell() {
        
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HistoryCell")
        
        tableView.rowHeight = 135.0
    }
    
    
    // MARK: - Fetch data from Core Data (Get or Read Data)
    func fetchItems() {
        let request: NSFetchRequest<HistoryCalculate> = HistoryCalculate.fetchRequest()
        
        do {
            historyCalculate = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Gagal mengambil data: \(error)")
        }
    }
    
    
    // MARK: - UITableViewDataSource (Menampilkan list table data)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyCalculate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell
        let data = historyCalculate[indexPath.row]
        
        let formattedWeightValue = String(format: "%.2f", data.weightValue)
        let formattedHeightValue = String(format: "%.2f", data.heightValue)
        
        cell.heighAndWeightLabel.text = "Height: \(formattedHeightValue) m   |   Weight: \(formattedWeightValue) Kg"
        cell.bmiValueLabel.text = "BMI: \(data.resultValue)"
        cell.adviceLabel.text = data.adviceValue
        
        return cell
    }
    
    
    // MARK: - Penambahan action swipe kanan pada row tabel dan Delete dari core data
    // Menambahkan action di kanan row tabel
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Tampilkan alert konfirmasi sebelum menghapus data
            self.showDeleteConfirmationAlert(indexPath: indexPath)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // Menampilkan alert konfirmasi delete
    func showDeleteConfirmationAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Konfirmasi", message: "Apakah Anda yakin ingin menghapus data ini?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ya", style: .destructive, handler: { _ in
            // Hapus item dari Core Data dan array
            self.deleteItem(at: indexPath)
        }))
        
        alert.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    // Delete data dari core data
    func deleteItem(at indexPath: IndexPath) {
        let itemToDelete = historyCalculate[indexPath.row]
        context.delete(itemToDelete)
        
        do {
            try context.save()
            historyCalculate.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Gagal menghapus data: \(error)")
        }
    }


    
}

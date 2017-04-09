//
//  MeteorResultTableViewController.swift
//  MeteoriteLanding
//
//  Created by Radim Langer on 08/04/2017.
//  Copyright © 2017 Radim Langer. All rights reserved.
//

import UIKit

class MeteorResultTableViewController: UITableViewController {

    private var didAnimateTableView: Bool = false
    private let apiHandler = APIHandler()
    private var meteoritesDataCollection: [Meteorite]? {
        didSet {
            didAnimateTableView ? tableView.reloadData() : animateTable()
        }
    }
    
    // MARK: lifecycle
    
    override func loadView() {
        super.loadView()
        
        getMeteorData()
    }
    
    // MARK: tableviewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let meteoritesData = meteoritesDataCollection else { return 0 }
        
        return meteoritesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "meteoriteTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MeteoriteTableViewCell
        
        guard let meteoritesData = meteoritesDataCollection else { return cell }
        
        let cellData = meteoritesData[indexPath.row]
        
        cell.nameLabel.text = cellData.name
        cell.massLabel.text = "Mass: \(cellData.mass)"
        
        cell.yearLabel.text = "Year: \(cellData.impactDateString)"
            
        return cell
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "meteoriteDetailSegue" {
            
            guard
                let destinationViewController = segue.destination as? MeteoriteDetailViewController,
                let selectedCell = sender as? MeteoriteTableViewCell,
                let indexPath = tableView.indexPath(for: selectedCell),
                let meteoritesData = meteoritesDataCollection
            else {
                return
            }
            
            destinationViewController.meteorData = meteoritesData[indexPath.row]
        }
    }
    
    // MARK: Actions
    
    @objc private func getMeteorData() {
        
        apiHandler.getMeteoritesData { meteoritesDataCollection, error in
            
            if let error = error {
                
                self.presentAlert(with: error.localizedDescription)
                NetworkReachability.updateMetheoritesWhenInternetComesAlive(in: self, selector: #selector(self.getMeteorData))
                
            } else {

                guard let meteoritesData = meteoritesDataCollection
                else {
                    self.presentAlert(with: "Could not get meteor data from the internet. Try again later.")
                    return
                }

                self.meteoritesDataCollection = MeteoriteCollectionSorter.sortData(meteoritesDataCollection: meteoritesData, option: .mass)
            }
        }
    }
    
    @IBAction func sortDataButton(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: nil, message: "Sort by:", preferredStyle: .actionSheet)
        
        guard let meteoritesData = meteoritesDataCollection else { return }
        
        let sortByMassAction = UIAlertAction(title: "Mass", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            
            self.meteoritesDataCollection = MeteoriteCollectionSorter.sortData(meteoritesDataCollection: meteoritesData, option: .mass)
        })
        
        let sortByYearAction = UIAlertAction(title: "Year", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            
            self.meteoritesDataCollection = MeteoriteCollectionSorter.sortData(meteoritesDataCollection: meteoritesData, option: .year)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenu.addAction(sortByMassAction)
        optionMenu.addAction(sortByYearAction)
        optionMenu.addAction(cancelAction)
        
        present(optionMenu, animated: true)
    }
    
    private func presentAlert(with title: String) {
        
        let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
        
    // MARK: animation
    
    func animateTable() {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for cell in cells {
            let cell: UITableViewCell = cell as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                
            }, completion: { _ in
                self.didAnimateTableView = true
            })
            
            index += 1
        }
    }
    
}

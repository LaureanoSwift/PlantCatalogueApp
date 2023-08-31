//  PlantListProgramaticVC.swift
//  PlantCatalogue
//
//  Created by Laureano Velasco on 13/06/2023.
//

import UIKit
import CoreData

// the class conform the protocols for the delegate pattern
final class PlantListProgramaticVC: UIViewController, SavePlantDelegate, EditPlantViewControllerDelegate {
    
    let context = CoreDataManager.shared.managedObjectContext
    private var externalPlantList = [PlantModel2]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .darkGreen
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(CustomCell.self, forCellReuseIdentifier: "\(CustomCell.self)")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        externalPlantList = CoreDataManager.getAllItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableWhenBack()
    }
    
    private func configureView() {
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        title = "Catalogo de Plantas"
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlant))
        navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    func didSelectSaveButton(image: UIImage, name: String, nickname: String, luz: String, riego: String, sustrato: String) {
        
        let newPlant = PlantModel2(context: context)
        newPlant.plantImage = image.pngData()
        newPlant.plantName = name
        newPlant.nickname = nickname
        newPlant.luz = luz
        newPlant.riego = riego
        newPlant.sustrato = sustrato
        
        do {
            try context.save()
            externalPlantList = CoreDataManager.getAllItems()
            self.tableView.reloadData()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func reloadTableWhenBack() {
        tableView.reloadData()
    }
}

extension PlantListProgramaticVC: UITableViewDelegate, UITableViewDataSource {
    
    //// - MARK: Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return externalPlantList.count
    }
    
    // - MARK: Draw de Cells in respecting row using setData function defined in CustomCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomCell.self)", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        
        let plant = externalPlantList[indexPath.row]
        
        cell.setData(plant)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlant = externalPlantList[indexPath.row]
        let viewController = DetailViewController(selectedPlant: selectedPlant, relatedPlants: externalPlantList)
        viewController.setData(selectedPlant)
        navigationController?.pushViewController(viewController, animated: true)
    }

    // - MARK: Context Menu
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let selectedPlant = externalPlantList[indexPath.row]
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu in
            
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive,
                                  state: .off) { _ in
                
                CoreDataManager.shared.deleteElement(item: selectedPlant, context: self.context)
                self.saveData()
            }
            
            let edit = UIAction(title: "Edit",
                                image: UIImage(systemName: "pencil"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                                state: .off) { _ in
                
                let vc = EditPlantViewController(selectedPlant: selectedPlant, relatedPlants: self.externalPlantList)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            self.saveData()
            return UIMenu(title: "\(indexPath.row)", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,delete])
        }
        
        return config
    }
    
    func saveData() {
        do {
            try self.context.save()
            self.externalPlantList = CoreDataManager.getAllItems()
            self.tableView.reloadData()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    @objc func addPlant() {
        let viewController = AddPlantViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}





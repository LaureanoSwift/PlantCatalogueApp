//  EditPlantViewController.swift
//  PlantCatalogue
//  Created by Laureano Velasco on 19/07/2023.
//

import UIKit
import CoreData

protocol EditPlantViewControllerDelegate {
    func reloadTableWhenBack()
}

class EditPlantViewController: UIViewController {
    
    var delegate: EditPlantViewControllerDelegate?
    
    let context = CoreDataManager.shared.managedObjectContext
    
    private let editedPlantImage: UIImageView = crearImage()
    private var plantImage: UIImage = UIImage()
    private let selectImageButton: UIButton = crearButton()
    private let saveButton: UIButton = crearButton()
    private let plantNameTextField: UITextField = createTextField(placeholder: "", text: "")
    private let plantNickNameTextField: UITextField = createTextField(placeholder: "", text: "")
    private let riegoTextField: UITextField = createTextField(placeholder: "", text: "")
    private let sustratoTextField: UITextField = createTextField(placeholder: "", text: "")
    private let luzTextField: UITextField = createTextField(placeholder: "", text: "")
    private let plantInfoStack: UIStackView = createStackView()
    
    // - MARK: Custom init to pass data
    private var selectedPlantToEdit: PlantModel2
    private var relatedPlantsToEdit: [PlantModel2]
    
    init(selectedPlant: PlantModel2, relatedPlants: [PlantModel2]) {
        self.selectedPlantToEdit = selectedPlant
        self.relatedPlantsToEdit = relatedPlants
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .midGreen
        selectImageButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
        selectImageButton.setTitle("Seleccionar Imagen", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        saveButton.setTitle("Guardar", for: .normal)
        setupView()
        setData()
    }
    
    func setupView() {
        view.addSubview(editedPlantImage)
        view.addSubview(selectImageButton)
        view.addSubview(plantNameTextField)
        view.addSubview(plantNickNameTextField)
        view.addSubview(luzTextField)
        view.addSubview(riegoTextField)
        view.addSubview(sustratoTextField)
        view.addSubview(plantInfoStack)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            editedPlantImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editedPlantImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            editedPlantImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            editedPlantImage.widthAnchor.constraint(equalToConstant: 200),
            editedPlantImage.heightAnchor.constraint(equalToConstant: 300),
            
            selectImageButton.topAnchor.constraint(equalTo: editedPlantImage.bottomAnchor, constant: 30),
            selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectImageButton.widthAnchor.constraint(equalToConstant: 100),
            
            plantNameTextField.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 20),
            plantNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            plantNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            plantNameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            plantNickNameTextField.topAnchor.constraint(equalTo: plantNameTextField.bottomAnchor, constant: 30),
            plantNickNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            plantNickNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            plantNickNameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            luzTextField.topAnchor.constraint(equalTo: plantNickNameTextField.bottomAnchor, constant: 20),
            luzTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            luzTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            luzTextField.heightAnchor.constraint(equalToConstant: 30),
            
            riegoTextField.topAnchor.constraint(equalTo: luzTextField.bottomAnchor, constant: 20),
            riegoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            riegoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            riegoTextField.heightAnchor.constraint(equalToConstant: 30),
            
            sustratoTextField.topAnchor.constraint(equalTo: riegoTextField.bottomAnchor, constant: 20),
            sustratoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sustratoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sustratoTextField.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.topAnchor.constraint(equalTo: sustratoTextField.bottomAnchor, constant: 50),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
    @objc func selectButtonAction() {
        let imageSelector = UIImagePickerController()
        imageSelector.sourceType = .photoLibrary
        imageSelector.delegate = self
        imageSelector.allowsEditing = true
        self.present(imageSelector, animated: true)
    }
    // MARK: - Save button action
    @objc func saveButtonAction() {
        guard let plantName = plantNameTextField.text,
              let plantNick = plantNickNameTextField.text,
              let luzText = luzTextField.text,
              let riegoText = riegoTextField.text,
              let sustratoText = sustratoTextField.text,
              let editedImage = editedPlantImage.image else {
                  return
              }
        
        selectedPlantToEdit.plantName = plantName
        selectedPlantToEdit.nickname = plantNick
        selectedPlantToEdit.luz = luzText
        selectedPlantToEdit.riego = riegoText
        selectedPlantToEdit.sustrato = sustratoText
        
        plantImage = editedImage
        
        func saveData() {
            do {
                try self.context.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
        delegate?.reloadTableWhenBack()
        navigationController?.popViewController(animated: true)
    }
    
    func setData() {
        
        guard let imagePlant = selectedPlantToEdit.plantImage else {
            return
        }
        
        editedPlantImage.image = UIImage(data: imagePlant)
        plantNickNameTextField.text = selectedPlantToEdit.nickname
        plantNameTextField.text = selectedPlantToEdit.plantName
        luzTextField.text = selectedPlantToEdit.luz
        riegoTextField.text = selectedPlantToEdit.riego
        sustratoTextField.text = selectedPlantToEdit.sustrato
    }
}

// - MARK: UIImagePicker funcions
extension EditPlantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            editedPlantImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//extension EditPlantViewController: UIAdaptivePresentationControllerDelegate {
//    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
//        self.delegate?.reloadTableWhenBack()
//    }
//}

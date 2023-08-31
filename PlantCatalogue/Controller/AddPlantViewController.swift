//  AddPlantViewController.swift
//  PlantCatalogue
//  Created by Laureano Velasco on 22/06/2023.
//

import UIKit

//PROTOCOL SAVE DELEGATE PATTERN
protocol SavePlantDelegate {
    func didSelectSaveButton(image: UIImage, name: String, nickname: String, luz: String, riego: String, sustrato: String)
}

final class AddPlantViewController: UIViewController {
    
    //private let _view = PlantView()
    
    private let editedPlantImage: UIImageView = crearImage()
    private var plantImage: UIImage = UIImage()
    private let selectImageButton: UIButton = crearButton()
    private let saveButton: UIButton = crearButton()
    
    private let plantNameTextField: UITextField = createTextField(placeholder: "Nombre Cientifico", text: "")
    private let plantNickNameTextField: UITextField = createTextField(placeholder: "Nombre Popular", text: "")
    
    private let riegoTextField: UITextField = createTextField(placeholder: "Riego", text: "")
    private let sustratoTextField: UITextField = createTextField(placeholder: "Sustrato", text: "")
    private let luzTextField: UITextField = createTextField(placeholder: "Luz", text: "")
    private var plantInformation: String = ""
    
    private let plantInfoStack: UIStackView = createStackView()
    
    var delegate: SavePlantDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConfiguration()
    }
    
//    override func loadView() {
//        view = _view
//    }
    
    private func setConfiguration() {
        view.backgroundColor = .darkGreen
        selectImageButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
        selectImageButton.setTitle("Seleccionar Imagen", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        saveButton.setTitle("Guardar", for: .normal)
    }
    
    private func setupView() {
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
            editedPlantImage.heightAnchor.constraint(equalToConstant: 200),
            
            selectImageButton.topAnchor.constraint(equalTo: editedPlantImage.bottomAnchor, constant: 30),
            selectImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectImageButton.widthAnchor.constraint(equalToConstant: 100),
            
            plantNameTextField.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 30),
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
        present(imageSelector, animated: true)
    }
    
    // - MARK: SAVE DELEGATE PATTERN
    @objc func saveButtonAction() {
        guard let deleteImage = UIImage(named: "deleteMark") else {
            return
        }
        
        let plantName = plantNameTextField.text ?? ""
        let plantNick = plantNickNameTextField.text ?? ""
        let riegoText: String = riegoTextField.text ?? ""
        let sustratoText: String = sustratoTextField.text ?? ""
        let luzText: String = luzTextField.text ?? ""
        let plantImage: UIImage = editedPlantImage.image ?? deleteImage
        
        let riego: String = "Riego: \(riegoText)"
        let sustrato: String = "Sustrato: \(sustratoText)"
        let luz: String = "Luz: \(luzText)"
        delegate?.didSelectSaveButton(image: plantImage ,name: plantName, nickname: plantNick, luz: luz, riego: riego, sustrato: sustrato )
        navigationController?.popViewController(animated: true)
    }
}

func createTextField(placeholder : String, text: String) -> UITextField {
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.text = text
    textField.layer.cornerRadius = 10
    textField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    textField.backgroundColor = .sweetBrown
    textField.textColor = .black
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
}

func createStackView() -> UIStackView {
    let infoStackView = UIStackView()
    infoStackView.axis = .vertical
    infoStackView.distribution = .equalSpacing
    infoStackView.translatesAutoresizingMaskIntoConstraints = false
    return infoStackView
}

func crearButton() -> UIButton {
    let button = UIButton(type: .system)
    button.backgroundColor = .sweetBrown
    button.tintColor = .black
    button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
    button.layer.cornerRadius = 15
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}

func crearImage() -> UIImageView {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "addImage")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
}

extension AddPlantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            editedPlantImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

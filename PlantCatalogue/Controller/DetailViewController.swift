//  DetailViewController.swift
//  PlantCatalogue
//  Created by Laureano Velasco on 16/06/2023.
//

import UIKit
import CoreData

final class DetailViewController: UIViewController {
    
    let context = CoreDataManager.shared.managedObjectContext
    private let plantNameLabel: UILabel = createLabel(size: 28)
    private let nicknameLabel: UILabel = createLabel(size: 22)
    private let luzLabel: UILabel = createLabel(size: 18)
    private let riegoLabel: UILabel = createLabel(size: 18)
    private let sustratoLabel: UILabel = createLabel(size: 18)
    
    private var plantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(plantImage)
        stack.addArrangedSubview(plantNameLabel)
        stack.addArrangedSubview(nicknameLabel)
        stack.addArrangedSubview(luzLabel)
        stack.addArrangedSubview(riegoLabel)
        stack.addArrangedSubview(sustratoLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .darkGreen
        setUpView()
    }
    
    private let selectedPlant: PlantModel2
    private var relatedPlants: [PlantModel2]
    
    init(selectedPlant: PlantModel2, relatedPlants: [PlantModel2]) {
        self.selectedPlant = selectedPlant
        self.relatedPlants = relatedPlants
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            plantImage.heightAnchor.constraint(equalToConstant: 300),
            plantImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            plantImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            plantNameLabel.topAnchor.constraint(equalTo: plantImage.bottomAnchor, constant: 20),
            plantNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            plantNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            nicknameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            nicknameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            luzLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            luzLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            riegoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            riegoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            sustratoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            sustratoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        ])
    }
    
    func setData(_ plant: PlantModel2) {
        guard let imagePlant = plant.plantImage else {
            return
        }
        
        plantImage.image = UIImage(data: imagePlant)
        nicknameLabel.text = plant.nickname
        plantNameLabel.text = plant.plantName
        luzLabel.text = plant.luz
        riegoLabel.text = plant.riego
        sustratoLabel.text = plant.sustrato
    }
}

func createLabel(size: CGFloat) -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: size, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.numberOfLines = 0
    label.backgroundColor = .sweetBrown
    label.layer.masksToBounds = true
    label.layer.cornerRadius = 5
    return label
}

func createButton(buttonTitle: String) -> UIButton {
    let button = UIButton()
    button.backgroundColor = .systemMint
    button.setTitle(buttonTitle, for: .normal)
    button.tintColor = .black
    button.layer.cornerRadius = 15
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
}





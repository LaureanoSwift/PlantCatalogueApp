//
//  CustomCell.swift
//  PlantCatalogue
//
//  Created by Laureano Velasco on 13/06/2023.
//

import UIKit

class CustomCell: UITableViewCell {
    
    private var plantImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var plantNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(plantNameLabel)
        stackView.addArrangedSubview(nicknameLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .midGreen
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //funcion que le pasa los valores de los atributos
    func setData(_ plant: PlantModel2){
        
        guard let imagePlant = plant.plantImage else {
            return
        }
        
        plantImage.image = UIImage(data: imagePlant)
        nicknameLabel.text = plant.nickname
        plantNameLabel.text = plant.plantName
    }
    

    private func setupView(){
        
        addSubview(plantImage)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([

            plantImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            plantImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            plantImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            plantImage.widthAnchor.constraint(equalToConstant: 60),
            plantImage.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: plantImage.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
        ])
    }
}

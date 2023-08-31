//
//  HeaderSectionCell.swift
//  PlantCatalogue
//
//  Created by Laureano Velasco on 14/06/2023.

//este archivo no fue usado en este proyecto

import UIKit

class HeaderSectionCell: UITableViewHeaderFooterView {
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var shareIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "cart.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //funcion que configura las constraints
    private func configureView(){
        
        addSubview(view)
        view.addSubview(headerLabel)
        view.addSubview(shareIcon)
        
        
        NSLayoutConstraint.activate([
        
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),

            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            shareIcon.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 10),
            shareIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shareIcon.heightAnchor.constraint(equalToConstant: 25),
            shareIcon.widthAnchor.constraint(equalToConstant: 25),
            shareIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ])
        
        
        }
    
    //funcion que le da el valor al titulo
    func setData(title: String){
        headerLabel.text = title
        
    }
    
}

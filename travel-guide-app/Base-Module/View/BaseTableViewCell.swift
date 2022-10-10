//
//  FlightsAndHotelsCell.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 1.10.2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    let name = UILabel()
    
    let image = UIImageView()
 
    let desc = UILabel()
    
    let darkView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //this order is important, cause of the layer level.
        //if we add something first, it will be placed behind the others.
        //for example if I add image last, name and desc will not be seen.
        contentView.addSubview(image)
        contentView.addSubview(darkView)
        contentView.addSubview(name)
        contentView.addSubview(desc)
        
        setupUI()
        setupConstraints()
    
    }
    
    func setupConstraints(){
        
        darkView.bounds = image.bounds
        
        image.topAnchor.constraint(equalTo: contentView.topAnchor,constant: contentView.bounds.width * 0.05).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: contentView.bounds.width * 0.05).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -contentView.bounds.width * 0.05).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -contentView.bounds.width * 0.05).isActive = true
        
        darkView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: contentView.bounds.width * 0.05).isActive = true
        darkView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: contentView.bounds.width * 0.05).isActive = true
        darkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -contentView.bounds.width * 0.05).isActive = true
        darkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -contentView.bounds.width * 0.05).isActive = true
        
        name.topAnchor.constraint(equalTo: image.topAnchor,constant: contentView.bounds.width * 0.15).isActive = true
        name.leadingAnchor.constraint(equalTo: image.leadingAnchor,constant: contentView.bounds.width * 0.05).isActive = true
        name.trailingAnchor.constraint(equalTo: image.trailingAnchor,constant: -contentView.bounds.width * 0.05).isActive = true
        
        desc.topAnchor.constraint(equalTo: name.bottomAnchor,constant: contentView.bounds.width * 0.005).isActive = true
        desc.leadingAnchor.constraint(equalTo: image.leadingAnchor,constant: contentView.bounds.width * 0.05).isActive = true
        desc.trailingAnchor.constraint(equalTo: image.trailingAnchor,constant: -contentView.bounds.width * 0.05).isActive = true
        desc.bottomAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
        
    }
    
    func setupUI(){
        
        //darkview config(to be able to see the white text labels)
        
        darkView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        darkView.layer.cornerRadius = 5
        darkView.translatesAutoresizingMaskIntoConstraints = false
        
        //image config
        
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        //description config
        
        desc.textAlignment = .center
        desc.font = UIFont.boldSystemFont(ofSize: contentView.bounds.width * 0.05)
        desc.textColor =  .white
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.numberOfLines = 0
        
        //name config
        
        name.textAlignment = .center
        name.font = UIFont.boldSystemFont(ofSize: contentView.bounds.width * 0.07)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}

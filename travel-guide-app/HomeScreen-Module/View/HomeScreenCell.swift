//
//  HomeScreenCell.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 30.09.2022.
//

import UIKit

class HomeScreenCell: UICollectionViewCell {
    
    let category = UILabel()
 
    let image = UIImageView()
    
    let name = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.addSubview(name)
        contentView.addSubview(category)
        contentView.addSubview(image)
        setupUI()
        setupConstraints()
        
    }
    
    override func awakeFromNib() {
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        //image config
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        image.translatesAutoresizingMaskIntoConstraints = false
        
        //category config
        
        category.textColor =  .blue
        category.numberOfLines = 0
        category.translatesAutoresizingMaskIntoConstraints = false
        
        //name config
        
        name.font = UIFont.boldSystemFont(ofSize: 16)
        name.numberOfLines = 0
        name.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupConstraints(){
  
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -100).isActive = true
   
        category.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 5).isActive = true
        category.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        category.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
      
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        name.topAnchor.constraint(equalTo: category.bottomAnchor,constant: 5).isActive = true
        
    }
    
}

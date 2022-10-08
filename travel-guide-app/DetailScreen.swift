//
//  DetailScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 4.10.2022.
//

import UIKit

class DetailScreen: UIViewController {

    let detailImage = UIImageView()
    
    let detailTitle = UILabel()
    
    let category = UILabel()
    
    let desc = UILabel()
    
    let detailButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(detailImage)
        view.addSubview(category)
        view.addSubview(detailTitle)
        view.addSubview(desc)
        view.addSubview(detailButton)
        
        setupUI()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(detailTransfer), name: .init(rawValue: "DetailTransfer"), object: nil)
        
    }
    
    @objc func detailTransfer(_ notification: NSNotification) {
        
        let dataTitle = (notification.userInfo as! [String:String])["title"]
        
        let dataCategory = (notification.userInfo as! [String:String])["category"]
        
        let dataImage = (notification.userInfo as! [String:String])["image"]
        
        let dataDescription = (notification.userInfo as! [String:String])["description"]
            
        detailTitle.text = dataTitle
        
        category.text = dataCategory
        
        let url: URL? = URL(string: dataImage ?? "")
        let data: Data? = try? Data(contentsOf : url!)
        detailImage.image = UIImage(data : data!)
        
        desc.text = dataDescription
        
    }
    
    func setupUI() {
        
        detailImage.image = UIImage(named: "")
        detailImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        detailImage.layer.cornerRadius = 20
        detailImage.clipsToBounds = true
        detailImage.translatesAutoresizingMaskIntoConstraints = false
        
        category.text = ""
        category.textColor = .blue
        category.translatesAutoresizingMaskIntoConstraints = false
        
        detailTitle.text = ""
        detailTitle.numberOfLines = 0
        detailTitle.font = UIFont.systemFont(ofSize: view.bounds.width * 0.07)
        detailTitle.translatesAutoresizingMaskIntoConstraints = false
        
        desc.text = ""
        desc.numberOfLines = 0
        
        desc.translatesAutoresizingMaskIntoConstraints = false
        
        detailButton.setTitle("Add Bookmark", for: .normal)
        detailButton.backgroundColor = .red
        detailButton.layer.cornerRadius = 5
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupConstraints() {
        
        detailImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailImage.bottomAnchor.constraint(equalTo: detailImage.topAnchor, constant: view.bounds.height * 0.5).isActive = true
        detailImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        category.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: view.bounds.height * 0.01).isActive = true
        category.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.bounds.width * 0.05).isActive = true
        category.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -view.bounds.width * 0.05).isActive = true
        category.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.05).isActive = true
        
        detailTitle.topAnchor.constraint(equalTo: category.bottomAnchor,constant: view.bounds.height * 0.01).isActive = true
        detailTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.bounds.width * 0.05).isActive = true
        detailTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -view.bounds.width * 0.05).isActive = true
        detailTitle.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.05).isActive = true
        
        desc.topAnchor.constraint(equalTo: detailTitle.bottomAnchor, constant: view.bounds.height * 0.01).isActive = true
        desc.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.bounds.width * 0.05).isActive = true
        desc.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -view.bounds.width * 0.05).isActive = true
        desc.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.25).isActive = true
        
        detailButton.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: view.bounds.height * 0.01).isActive = true
        detailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.1).isActive = true
        detailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05).isActive = true
        detailButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -view.bounds.height * 0.05).isActive = true
        
    }
    

}



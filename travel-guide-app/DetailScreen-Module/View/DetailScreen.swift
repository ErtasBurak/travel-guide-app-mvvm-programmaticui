//
//  DetailScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 4.10.2022.
//

import UIKit
import CoreData

class DetailScreen: UIViewController {

    let detailImage = UIImageView()
    
    let detailTitle = UILabel()
    
    let category = UILabel()
    
    let desc = UILabel()
    
    let detailButton = UIButton()
    
    var hideButtonBookmark: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(detailImage)
        view.addSubview(category)
        view.addSubview(detailTitle)
        view.addSubview(desc)
        
        
        setupUI()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(detailTransfer), name: .init(rawValue: "DetailTransfer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bookMarkTransfer), name: .init(rawValue: "BookmarkTransfer"), object: nil)
        
        
        
        
    }
    
    @objc func detailTransfer(_ notification: NSNotification) {
        
        let dataTitle = (notification.userInfo as! [String:String])["title"]
        
        let dataCategory = (notification.userInfo as! [String:String])["category"]
        
        let dataImage = (notification.userInfo as! [String:String])["image"]
        
        let dataDescription = (notification.userInfo as! [String:String])["description"]
        
        
            
        detailTitle.text = dataTitle
        
        category.text = dataCategory
        
        if let url: URL = URL(string: dataImage ?? "") {
            DispatchQueue.global().async {
                if let data: Data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.detailImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        desc.text = dataDescription
        
    }
    
    @objc func bookMarkTransfer(_ notification: NSNotification) {
        
        let dataTitle = (notification.userInfo as! [String:Any])["title"]
        detailTitle.text = dataTitle as? String
        
        let dataCategory = (notification.userInfo as! [String:Any])["category"]
        category.text = dataCategory as? String
        
        let dataDescription = (notification.userInfo as! [String:Any])["description"]
        desc.text = dataDescription as? String
        
        let imageData = (notification.userInfo as! [String:Any])["imageData"]
        detailImage.image = UIImage(data : imageData! as! Data)
        
        let hideButton = (notification.userInfo as! [String:Any])["buttonHide"]
        hideButtonBookmark = hideButton! as? Bool
        
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
        detailButton.addTarget(self, action: #selector(addBookmarkTapped), for: .touchUpInside)
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc func addBookmarkTapped() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let travel = NSEntityDescription.insertNewObject(forEntityName: "Travel", into: context)
        
        travel.setValue(detailTitle.text!, forKey: "titleTravel")
        travel.setValue(category.text!, forKey: "categoryTravel")
        travel.setValue(desc.text!, forKey: "descriptionTravel")
        travel.setValue(UUID(), forKey: "idTravel")
        
        let data = detailImage.image!.jpegData(compressionQuality: 0.5)
        
        
        travel.setValue(data, forKey: "imageTravel")
        
        do {
            try context.save()
            print("save complete")
        } catch {
            print("error found")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataSaved"), object: nil)
        navigationController?.pushViewController(BookMarksScreen(), animated: true)
        
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
        
        //button configuration for bookmarkscreen and other screens
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            if self.hideButtonBookmark == true {
                self.detailButton.isEnabled = false
                self.detailButton.isHidden = true
            }else{
                self.detailButton.isEnabled = true
                self.detailButton.isHidden = false
                self.view.addSubview(self.detailButton)
                self.detailButton.topAnchor.constraint(equalTo: self.desc.bottomAnchor, constant: self.view.bounds.height * 0.01).isActive = true
                self.detailButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.view.bounds.width * 0.1).isActive = true
                self.detailButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width * 0.05).isActive = true
                self.detailButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -self.view.bounds.height * 0.05).isActive = true
            }
            
        }
        
    }
    

}



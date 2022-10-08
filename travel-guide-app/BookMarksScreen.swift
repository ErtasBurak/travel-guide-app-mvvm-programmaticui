//
//  BookMarksScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit

class BookMarksScreen: UIViewController {
    
    let bookMarkLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(bookMarkLabel)
        
        setupUI()
        
    }
    
    func setupUI(){
        
        bookMarkLabel.text = "Bookmarks"
        bookMarkLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.width * 0.1)
        bookMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bookMarkLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        bookMarkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05).isActive = true
        
    }
    
}

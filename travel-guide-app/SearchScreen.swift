//
//  SearchScreen.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit

class SearchScreen: UIViewController, UISearchBarDelegate {

    let searchLabel = UILabel()
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(searchLabel)
        view.addSubview(searchBar)
        
        
        searchBar.delegate = self
        
        setupUI()
        
    }
    
    func setupUI(){
        
        searchLabel.text = "Search"
        searchLabel.font = UIFont.boldSystemFont(ofSize: view.bounds.width * 0.1)
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        searchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.1).isActive = true
        searchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05).isActive = true
        
        searchBar.placeholder = "Where next?"
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.topAnchor.constraint(equalTo: searchLabel.bottomAnchor,constant: view.bounds.height * 0.05).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.bounds.width * 0.05).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -view.bounds.width * 0.05).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.1).isActive = true

    }
    
}

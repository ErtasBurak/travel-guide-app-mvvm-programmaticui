//
//  ViewController.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 28.09.2022.
//

import UIKit

class TabBar: UITabBarController, UITabBarControllerDelegate  {
    
    let homeIcon = UIImage(named: "home")
    
    let selectedHome = UIImage(named: "homeselected")
    
    let searchIcon = UIImage(named: "search")
    
    let selectedSearch = UIImage(named: "selectedSearch")
    
    let bookmark = UIImage(named: "bookmark")
    
    let selectedBookmark = UIImage(named: "bookmarkselected")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        setupTabBars()
  
    }
    
    
    func setupTabBars(){
        // Create Tab one
        let tabOne = HomeScreenBuilder.createHomeScreen()
        let tabOneBarItem = UITabBarItem(title: nil, image: homeIcon, selectedImage: selectedHome)

        tabOne.tabBarItem = tabOneBarItem
        
        // Create Tab two
        let tabTwo = SearchScreenBuilder.createSearchScreen()
        let tabTwoBarItem2 = UITabBarItem(title: nil, image: searchIcon, selectedImage: selectedSearch)
        tabTwo.tabBarItem = tabTwoBarItem2
        
        // Create Tab ToDo
        let toDo = BookMarksScreen()
        let tabTodoBarItem = UITabBarItem(title: nil, image: bookmark, selectedImage: selectedBookmark)
        
        toDo.tabBarItem = tabTodoBarItem
  
        self.viewControllers = [tabOne, tabTwo, toDo]
        
        self.tabBar.backgroundColor = .white //default color is black and we can not see the second tab because it has gray color
    }
    
}


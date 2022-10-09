//
//  SearchScreenBuilder.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 8.10.2022.
//

import UIKit

struct SearchScreenBuilder {
    
    static func createSearchScreen() -> UIViewController {
        
        let vc = SearchScreen()
        let viewModel = HomeScreenViewModel()
        let model = HomeScreenModel()
        let router = HomeScreenRouter()
        
        router.viewController = vc
        viewModel.view = vc
        viewModel.router = router
        viewModel.model = model
        vc.viewModel = viewModel
        model.viewModel = viewModel
        
        return vc
    }
    
}

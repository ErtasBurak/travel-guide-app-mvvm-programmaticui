//
//  HomeScreenBuilder.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 5.10.2022.
//

import UIKit

struct HomeScreenBuilder {
    
    static func createHomeScreen() -> UIViewController {
        
        let vc = HomeScreen()
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

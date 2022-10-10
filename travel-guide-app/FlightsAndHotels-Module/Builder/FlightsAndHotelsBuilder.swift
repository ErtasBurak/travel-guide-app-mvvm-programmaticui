//
//  FlightsAndHotelsBuilder.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 5.10.2022.
//

import UIKit

struct FlightsAndHotelsBuilder {
    
    static func createFlightsAndHotelsScreen() -> UIViewController {
        
        let vc = FlightsAndHotels()
        let viewModel = BaseViewModel()
        let model = BaseModel()
        let router = BaseRouter()
        
        router.viewController = vc
        viewModel.view = vc
        viewModel.router = router
        viewModel.model = model
        vc.viewModel = viewModel
        model.viewModel = viewModel
        
        return vc
    }
    
}

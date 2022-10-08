//
//  HomeRouter.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 5.10.2022.
//

import UIKit

class HomeScreenRouter {
    
    weak var viewController: UIViewController?
    
    
    
    func navigateToDetail(_ data: HomeData) {
        
        let vc = DetailScreen()
        viewController?.navigationController?.pushViewController(vc, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            
            let userInfo: [String:String] = ["title": data.title!, "category": data.category!, "image": data.images![0].url!, "description": data.homeDataDescription!]
            
            NotificationCenter.default.post(name: .init(rawValue: "DetailTransfer"), object: nil, userInfo: userInfo)
            
        }
        
    }
    
}



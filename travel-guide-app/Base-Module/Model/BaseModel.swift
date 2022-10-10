//
//  HomeScreenModel.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 5.10.2022.
//

import Foundation

class BaseModel {
    
    weak var viewModel: BaseViewModel?
    
    var dataHome: [BaseData] = []
    
    func fetchHomeData() {
        guard let url = URL.init(string: "https://633f7631e44b83bc73bab811.mockapi.io/all_travel_list") else {
            viewModel?.didDataNotFetch()
            return
        }
        
        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {return}
            
            guard error == nil else {
                self.viewModel?.didDataNotFetch()
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            guard
                statusCode >= 200,
                statusCode < 300
            else{
                self.viewModel?.didDataNotFetch()
                return
            }
            
            guard let data = data else {
                self.viewModel?.didDataNotFetch()
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                self.dataHome = try jsonDecoder.decode([BaseData].self, from: data)
                self.viewModel?.didDataFetch()
            } catch {
                self.viewModel?.didDataNotFetch()
            }
        }
        
        task.resume()
    }
    
}

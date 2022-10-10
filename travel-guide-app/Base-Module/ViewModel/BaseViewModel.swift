//
//  HomeScreenViewModel.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 5.10.2022.
//

import Foundation

class BaseViewModel {
    
    var uiModel: [BaseDataTableCell] = []
    
    var view: BaseProtocol!
    var router: BaseRouter!
    var model: BaseModel!
    
    
    func didViewLoad() {
        view.showLoading()
        model.fetchHomeData()
    }
    
    func didDataFetch() {
        view.hideLoading()
        
        uiModel = model.dataHome.map { makeUIModel($0) }
        
        view.updateUI()
    }
    
    func didDataNotFetch() {
        view.hideLoading()
        view.showError(with: "Data couldn't fetch!")
    }
    
    func didSelectData(at index: IndexPath) {
        let data = model.dataHome[index.row]
        router.navigateToDetail(data)
    }
    
    func numberOfItems() -> Int {
        return uiModel.count
    }
    
    func getItem(for indexPath: IndexPath) -> BaseDataTableCell {
        return uiModel[indexPath.row]
    }
    
    private func makeUIModel(_ data: BaseData) -> BaseDataTableCell {
        .init(imageUrl: data.images![0].url! , title: data.title ?? "", category: data.category ?? "", description: data.homeDataDescription ?? "")
    }
}

//
//  BaseProtocol.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 10.10.2022.
//

import Foundation

protocol BaseProtocol {
    
    func updateUI()
    func showLoading()
    func hideLoading()
    func showError(with message: String?)
}

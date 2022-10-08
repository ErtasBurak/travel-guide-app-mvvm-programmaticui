//
//  HomeScreenEntities.swift
//  travel-guide-app
//
//  Created by Burak Ertaş on 5.10.2022.
//

import Foundation

struct HomeDataTableCellModel {
    let imageUrl: String
    let title: String
    let category: String
    let description: String
}


struct HomeData: Decodable {
    let title, homeDataDescription, category, country: String?
    let city: String?
    let images: [Image]?
    let isBookmark: Bool?
    let id: String?


    enum CodingKeys: String, CodingKey {
        case title
        case homeDataDescription = "description"
        case category, country, city, images, isBookmark, id

    }
}

struct Image: Decodable {
    let height, width: Int?
    let url: String?
    let isHeroImage: Bool?
}

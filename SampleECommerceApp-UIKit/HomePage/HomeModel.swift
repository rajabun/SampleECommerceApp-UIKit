//
//  HomeModel.swift
//  SampleECommerceApp-UIKit
//
//  Created by Muhammad Rajab Priharsanto on 26/06/21.
//

import Foundation

struct HomeModel: Decodable {
    let data: HomeDataModel
}

struct HomeDataModel: Decodable {
    let category: [CategoryModel]
    let productPromo: [ProductPromoModel]
}

struct CategoryModel: Decodable {
    let imageUrl: String
    let id: Int
    let name: String
}

struct ProductPromoModel: Decodable {
    let id: String
    let imageUrl: String
    let title: String
    let description: String
    let price: String
    let loved: Int
}

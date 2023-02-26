//
//  HomaModel.swift
//  Ecomerse
//
//  Created by anmy on 24/02/23.
//

import Foundation

class HomeModel : Codable {
    
    var homeData : [HomeData]?
    
}

class HomeData : Codable {
    
    var type : String?
    var values: [HomeDataValues]?
    
}

class HomeDataValues : Codable {
    
    var id : Int?
    var name: String?
    var imageUrl: String?
    var bannerUrl: String?
    var productImage: String?
    var actualPrice: String?
    var offerPrice: String?
    var offer: Int?
    var isExpress: Bool?
    
    enum CodingKeys: String, CodingKey {
            case id, name, offer
            case productImage = "image"
            case imageUrl = "image_url"
            case bannerUrl = "banner_url"
            case actualPrice = "actual_price"
            case offerPrice = "offer_price"
            case isExpress = "is_express"
        }
    
}

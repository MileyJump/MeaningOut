//
//  ShoppingModel.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit

struct ShoppingModel: Decodable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Items]
}

struct Items: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String 
    let mallName: String
    let productId: String
    let productType: String
    let brand: String
    let maker: String
    let category1: String
    let category2: String
    let category3: String
    let category4: String
}


struct LikeStatus {
    var isLiked: Bool = false // 좋아요 상태
}

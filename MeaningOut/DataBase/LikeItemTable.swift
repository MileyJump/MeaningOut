//
//  LikeItem.swift
//  MeaningOut
//
//  Created by 최민경 on 7/20/24.
//

import RealmSwift


class LikeItemTable: Object {
    
    @Persisted(primaryKey: true) var productId: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var lprice: String
    @Persisted var mallName: String
    
    
    convenience init(productId: String, title: String, link: String, image: String, lprice: String, mallName: String) {
        self.init()
        self.productId = productId
        self.title = title
        self.link = link
        self.image = image
        self.lprice = lprice
        self.mallName = mallName
    }
}


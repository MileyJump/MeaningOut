//
//  ShoppingTable.swift
//  MeaningOut
//
//  Created by 최민경 on 7/20/24.
//

import Foundation
import RealmSwift


class ShoppingTable: Object {
    // id = pk
    // - ObjectId : Realm에서 만든 ID 타입
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var userName: String
    @Persisted var userProfileName: String
    @Persisted var userJoinDate: String
    @Persisted var userLikeItem: List<LikeItemTable>
    @Persisted var userSearchKeyword: List<String>
    
    convenience init(userName: String, userProfileName: String, userJoinDate: String, userLikeItem: List<LikeItemTable>, userSearchKeyword: List<String> ) {
        self.init()
        self.userName = userName
        self.userProfileName = userProfileName
        self.userJoinDate = userJoinDate
        self.userLikeItem = userLikeItem
        self.userSearchKeyword = userSearchKeyword
    }
}



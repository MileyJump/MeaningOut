//
//  ShoppingTableRepository.swift
//  MeaningOut
//
//  Created by 최민경 on 7/20/24.
//

import Foundation
import RealmSwift

class ShoppingTableRepository {
    private let realm = try! Realm()
    
   
    
    // Realm 가져오기
    func fetchShopping() -> [ShoppingTable] {
        let value = realm.objects(ShoppingTable.self)
        return Array(value)
    }
    
    func fetchLikeitems() -> [LikeItemTable] {
        let value = realm.objects(LikeItemTable.self)
        return Array(value)
    }
    
    func fetchLikeItem(id: String) -> LikeItemTable? {
        let value = realm.object(ofType: LikeItemTable.self, forPrimaryKey: id)
        return value
    }
    
    // Realm 추가하기
//    func createItem(shopping: ShoppingTable, likeItem: LikeItemTable) {
//        do {
//            try realm.write {
//                shopping.userLikeItem.append(likeItem)
//                print("Realm Create Succeed")
//            }
//        } catch {
//            print("Realm append Error")
//        }
//    }
    
    
    func createItem(likeItem: LikeItemTable) {
        do {
            try realm.write {
                realm.add(likeItem)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm append Error")
        }
    }
    
    // Realm 업데이트
    func updateItem(_ completionHandler: () -> Void) {
        do {
            try realm.write {
                completionHandler()
            }
        } catch {
            print("Realm Update Failed")
        }
    }
    
    // Realm 삭제하기
    func deleteShopping(shopping: ShoppingTable) {
        do {
            try realm.write {
                realm.delete(shopping.userLikeItem)
                realm.delete(shopping)
                print("Realm Delete Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }
    
    func deleteItem(likeItem: LikeItemTable) {
        if let item = fetchLikeItem(id: likeItem.productId) {
            do {
                try realm.write {
                    realm.delete(item)
                    print("Realm Delete Succeed")
                }
            } catch {
                print("Realm Error")
            }
        }
    }
    
}

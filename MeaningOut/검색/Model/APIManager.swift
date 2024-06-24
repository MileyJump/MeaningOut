////
////  APIManager.swift
////  MeaningOut
////
////  Created by 최민경 on 6/21/24.
////
//
//import UIKit
//import Alamofire
//
//class APIManager {
//    
//    static let shared = APIManager()
//    
//    private init() { }
//    
//    func getSearch(query: String, sortText: String, completionHandler: @escaping (String) -> Void) {
//        let url = "\(APIURL.naverShoppingURL)query=\(query)&display=30&sort=\(sortText)"
//        
//        
//        let headers: HTTPHeaders = [
//            "X-Naver-Client-Id": APIKey.naverId,
//            "X-Naver-Client-Secret": APIKey.naverKey
//        ]
//        
//        AF.request(url, method: .get, headers: headers).responseDecodable(of: ShoppingModel.self) { response in
//            
//            switch response.result {
//            case .success(let value):
//                
//                
//                if self.page == 1 {
//                    self.shoppingData = value.items // 첫 페이지 요청일 경우 데이터 초기화
//                } else {
//                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
//                    self.shoppingData = value.items // 첫 페이지 요청일 경우 데이터 초기화
//                    self.shoppingData.append(contentsOf: value.items) // 다음 페이지일 경우 데이터 추가
//                    
//                }
//                self.searchResultCount = value.total
//                self.collectionView.reloadData() // UI 업데이트
//                         
//                
//                self.likeStatuses = Array(repeating: LikeStatus(), count: self.shoppingData.count)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}

//
//  ShoppingTabBar.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit

enum ShoppingTabBar {
    
    case searchTabBar
    case likeTabBar
    case SettingTabBar
    
    var viewController: UIViewController {
        switch self {
        case .searchTabBar:
            return SettingViewController()
        case .likeTabBar:
            return SearchResultsViewController()
        case .SettingTabBar:
            return LikeViewController()
        }
    }
    
    var title: String {
        switch self {
        case .searchTabBar:
            "검색"
        case .likeTabBar:
            "좋아요"
        case .SettingTabBar:
            "마이페이지"
        }
    }
    
    
    var image: UIImage? {
        switch self {
        case .searchTabBar:
            return UIImage(systemName: "")
        case .likeTabBar:
            return UIImage(systemName: "")
        case .SettingTabBar:
            return UIImage(systemName: "")
        }
    }
    
    var selectImage: UIImage? {
        switch self {
        case .searchTabBar:
            return UIImage(systemName:  "")
        case .likeTabBar:
            return UIImage(systemName: "")
        case .SettingTabBar:
            return UIImage(systemName: "")
        }
    }
}
    


//
//  ShoppingTabBar.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit

enum ShoppingTabBar {
    
    case searchTabBar
    case SettingTabBar
    case likeTabBar
    
    var viewController: UIViewController {
        switch self {
        case .searchTabBar:
            return ShoppingSearchViewController()
        case .SettingTabBar:
            return SettingViewController()
        case .likeTabBar:
            return LikeViewController()
        }
    }
    
    var title: String {
        switch self {
        case .searchTabBar:
            return "검색"
        case .SettingTabBar:
            return "마이페이지"
        case .likeTabBar:
            return "좋아요"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .searchTabBar:
            return UIImage(systemName: "magnifyingglass")
        case .SettingTabBar:
            return UIImage(systemName: "person")
        case .likeTabBar:
            return UIImage(systemName: "heart")
        }
    }
    
    var selectImage: UIImage? {
        switch self {
        case .searchTabBar:
            return UIImage(systemName: "magnifyingglass")
        case .SettingTabBar:
            return UIImage(systemName: "person.fill")
        case .likeTabBar:
            return UIImage(systemName: "heart.fill")
        }
    }
}
    


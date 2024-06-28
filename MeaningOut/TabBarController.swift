//
//  TabBarController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = ShoppingSearchViewController()
        let nav1 = UINavigationController(rootViewController: search)
        nav1.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let setting = SettingViewController()
        let nav2 = UINavigationController(rootViewController: setting)
        nav2.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1, nav2], animated: true)
    }
}

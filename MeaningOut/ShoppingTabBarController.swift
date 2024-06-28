//
//  TabBarController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class ShoppingTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs: [ShoppingTabBar] = [.searchTabBar, .likeTabBar, .SettingTabBar]
        
        var viewControllers: [UINavigationController] = []
        
        for (index, tabBar) in tabs.enumerated() {
            let vc = tabBar.viewController
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: tabBar.title, image: tabBar.image, tag: index)
            nav.tabBarItem.selectedImage = tabBar.selectImage
            viewControllers.append(nav)
        }
        
        setViewControllers(viewControllers, animated: true)
        tabBar.tintColor = .customMainColor
    }
}

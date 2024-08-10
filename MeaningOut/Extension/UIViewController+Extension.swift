//
//  UIViewController+Extension.swift
//  MeaningOut
//
//  Created by 최민경 on 6/24/24.
//

import UIKit


extension UIViewController {
    
    func showAlert(title: String, message: String, ok: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: ok, style: .destructive) { _ in
            UserDefaults.standard.set(false, forKey: "isUser")
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    
    func changeRootViewController(rootViewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = (windowScene.delegate as? SceneDelegate)?.window else { return }
        if let _ = rootViewController as? UITabBarController {
            window.rootViewController = rootViewController
        } else {
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.navigationBar.tintColor = UIColor.black
            configureNavigationBarAppearance(for: navigationController.navigationBar, font: UIFont.boldSystemFont(ofSize: 16), textColor: .black)
            
            window.rootViewController = navigationController
        }
        
        window.makeKeyAndVisible()
    }
    
    
    func configureNavigationBarAppearance(for navigationBar: UINavigationBar, font: UIFont, textColor: UIColor) {
         let navigationBarAppearance = UINavigationBarAppearance()
         
         navigationBarAppearance.titleTextAttributes = [
             NSAttributedString.Key.font: font,
             NSAttributedString.Key.foregroundColor: textColor
         ]
         
         navigationBar.standardAppearance = navigationBarAppearance
         navigationBar.scrollEdgeAppearance = navigationBarAppearance
     }
 }

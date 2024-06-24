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
}

//
//  UIButton+Extension.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit

extension UIButton {
    
    func configureButton(title: String, cornerRadius: CGFloat) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 13)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.customLightGray.cgColor
        self.setTitleColor(.black, for: .normal)
    }
}

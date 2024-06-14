//
//  UIImageView+Extension.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

extension UIImageView {
    
    func configureImageView(backgroundColor: UIColor, borderWidth: CGFloat, borderColor: CGColor) {
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.tintColor = .white
    }
}



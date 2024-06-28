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
    
    func cameraButton() {
        self.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        self.backgroundColor = .customMainColor
        self.imageView?.contentMode = .scaleAspectFit // 이미지를 버튼 크기에 맞게 조절하기 위해
        
        // 이미지 여백 설정
        let inset: CGFloat = 6
        self.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        self.setTitleColor(.white, for: .normal)
        self.tintColor = .white
        self.clipsToBounds = true
    }
}

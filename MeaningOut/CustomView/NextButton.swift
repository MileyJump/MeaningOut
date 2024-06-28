//
//  NextButton.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class NextButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(CustomColor.ButtonColor.nextTitle, for: .normal)
        backgroundColor = CustomColor.ButtonColor.background
        titleLabel?.font = FontType.pretendardBold.pretendardFont(ofsize: 15)
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CameraButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}

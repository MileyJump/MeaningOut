//
//  Resource.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

enum CustomColor {
    enum ButtonColor {
        static let nextTitle: UIColor = .white
        static let background: UIColor = .customMainColor
    }
}


enum FontType {
    case pretendardBlack
    case pretendardBold
    case pretendardLight
    case pretendardMedium
    case pretendardRegular
    case pretendardSemiBold
    
    func pretendardFont(ofsize fontSize: CGFloat) -> UIFont? {
        switch self {
        case .pretendardBlack:
            return UIFont(name: "Pretendard-Black", size: fontSize)
        case .pretendardBold:
            return UIFont(name: "Pretendard-Bold", size: fontSize)
        case .pretendardLight:
            return UIFont(name: "Pretendard-Light", size: fontSize)
        case .pretendardMedium:
            return UIFont(name: "Pretendard-Medium", size: fontSize)
        case .pretendardRegular:
            return UIFont(name: "Pretendard-Regular", size: fontSize)
        case .pretendardSemiBold:
            return UIFont(name: "Pretendard-SemiBold", size: fontSize)
        }
    }
}

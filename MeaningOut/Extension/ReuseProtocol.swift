//
//  ReuseProtocol.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

protocol ReuseProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReuseProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    
    
}

extension UICollectionViewCell: ReuseProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

//
//  BaseView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/27/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(* , unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { 
        backgroundColor = .white
    }
    
    
    
    
    
}

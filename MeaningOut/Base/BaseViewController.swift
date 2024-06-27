//
//  BaseViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/27/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureView() { 
        view.backgroundColor = .white
    }
}





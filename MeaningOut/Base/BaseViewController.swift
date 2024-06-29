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
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .customLightGray
        appearance.backgroundColor = .white
        if let customFont = FontType.pretendardMedium.pretendardFont(ofsize: 16) {
            appearance.titleTextAttributes = [.font : customFont, .foregroundColor: UIColor.black]
        }
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }
}





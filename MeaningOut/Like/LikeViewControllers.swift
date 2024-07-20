//
//  LikeViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/29/24.
//

import UIKit

class LikeViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "찜"
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        
        navigationItem.rightBarButtonItem = search
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchResultsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

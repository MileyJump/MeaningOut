//
//  DetailProductViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit
import WebKit

class DetailProductViewController: UIViewController {
    
    var likeButtonType: Bool = false
    
    let webView = WKWebView()
    var productName: String = ""
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callRequest()
        configureHierarchy()
        configureLayout()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        
        navigationItem.title = productName
        var likeButtonImage = likeButtonType ? "like_selected" : "like_unselected"
        let like = UIBarButtonItem(image: UIImage(named: likeButtonImage), style: .plain, target: self, action: #selector(likeButtonClicked))
//        like.tintColor = .white
        
//        navigationItem.rightBarButtonItem?.tintColor = .white
       
        navigationItem.rightBarButtonItem = like
        
    }
    
    @objc func likeButtonClicked() {
        print("====")
    }
    
    func callRequest() {
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func configureHierarchy() {
        view.addSubview(webView)
    }
    
    func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


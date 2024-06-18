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
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        callRequest()
        configureHierarchy()
        configureLayout()
        updateLikeButtonImage()
    }
    
    // MARK: - view 구성
    
    func configureView() {
        view.backgroundColor = .white
        navigationItem.title = productName
    }
    
    // MARK: - SetUpAddTarget
    
    @objc func likeButtonClicked() {
        likeButtonType.toggle()
        print(likeButtonType)
        updateLikeButtonImage()
    }
    
    // MARK: - 기능
    
    func updateLikeButtonImage() {
        let likeButtonImage = likeButtonType ? UIImage(named: "like_selected") : UIImage(named: "like_unselected")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: likeButtonImage, style: .plain, target: self, action: #selector(likeButtonClicked))
    }
    
    func callRequest() {
        guard let url = URL(string: link) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - 레이아웃
    
    func configureHierarchy() {
        view.addSubview(webView)
    }
    
    func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


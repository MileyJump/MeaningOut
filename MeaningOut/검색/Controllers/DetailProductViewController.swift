//
//  DetailProductViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit
import WebKit

class DetailProductViewController: BaseViewController {
    
    var likeButtonType: Bool = false
    
    let webView = WKWebView()
    var productName: String = ""
    var link = ""
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        updateLikeButtonImage()
    }
    
    // MARK: - view 구성
    
    override func configureView() {
        super.configureView()
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
    
    override func configureHierarchy() {
        view.addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


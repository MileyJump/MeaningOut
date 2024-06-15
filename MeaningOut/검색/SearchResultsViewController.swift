//
//  SearchResultsViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit
import Alamofire

class SearchResultsViewController: UIViewController {
    
    var searchResult: String = "키보드"
    var searchResultCount: Int = 0 {
        didSet {
            updateSearchtotal()
        }
    }
    
    var page = 1
    
    var shoppingData: [Items] = []
    
    lazy var searchResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customMainColor
        label.text = "\(searchResultCount)개의 검색 결과"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let accuracyButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "정확도", cornerRadius: 16)
        return button
    }()
    
    let dateButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "날짜순", cornerRadius: 16)
        return button
    }()
    
    let highPrice: UIButton = {
        let button = UIButton()
        button.configureButton(title: "가격높은순", cornerRadius: 16)
        return button
    }()
    
    let lowestPrice: UIButton = {
        let button = UIButton()
        button.configureButton(title: "가격낮은순", cornerRadius: 16)
        return button
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 15
        let cellSpacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing)
        layout.itemSize = CGSize(width: width/2, height: width)
        layout.minimumLineSpacing = cellSpacing - 10
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        callRequest(query: searchResult)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
//        shoppingData[sender.tag].like.toggle()
        
        collectionView.reloadData()
    }
    
    func callRequest(query: String) {
        let url = "\(APIURL.naverShoppingURL)query=\(query)&display=30"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverId,
            "X-Naver-Client-Secret": APIKey.naverKey
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: ShoppingModel.self) { response in
            switch response.result {
            case .success(let value):
                
//                if self.page == 1 {
//                    self.shoppingData = value.items
                    self.searchResultCount = value.total
//                } else {
                    self.shoppingData.append(contentsOf: value.items)
//                }
                self.collectionView.reloadData()
                
                if self.page == 1 {
                    self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
                
        
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateSearchtotal() {
        
        let count = Int(searchResultCount)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // 3자리마다 콤마를 추가하는 형식
        
        if let result = formatter.string(for: count) {
            searchResultLabel.text = result + "개의 검색 결과"
        }
    }
    
    
    func configureView() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .customLightGray
        appearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.title = searchResult
        navigationItem.backButtonTitle = ""
//        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
    }
    
    func configureHierarchy() {
        view.addSubview(searchResultLabel)
        view.addSubview(accuracyButton)
        view.addSubview(dateButton)
        view.addSubview(highPrice)
        view.addSubview(lowestPrice)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        searchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        accuracyButton.snp.makeConstraints { make in
            make.top.equalTo(searchResultLabel.snp.bottom).offset(15)
            make.leading.equalTo(searchResultLabel.snp.leading)
            make.height.equalTo(35)
            make.width.equalTo(55)
        }
        
        dateButton.snp.makeConstraints { make in
            make.size.verticalEdges.equalTo(accuracyButton)
            make.leading.equalTo(accuracyButton.snp.trailing).offset(10)
        }
        
        highPrice.snp.makeConstraints { make in
            make.height.verticalEdges.equalTo(accuracyButton)
            make.width.equalTo(80)
            make.leading.equalTo(dateButton.snp.trailing).offset(10)
        } 
        
        lowestPrice.snp.makeConstraints { make in
            make.size.verticalEdges.equalTo(highPrice)
            make.leading.equalTo(highPrice.snp.trailing).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(accuracyButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
}

extension SearchResultsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if shoppingData.count - 2 == item.row {
                page += 1
                callRequest(query: searchResult)
            }
        }
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoppingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultsCollectionViewCell.identifier, for: indexPath) as! SearchResultsCollectionViewCell
        cell.configureCell(shoppingData[indexPath.row])
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = DetailProductViewController()
        vc.link = shoppingData[indexPath.row].link
        vc.productName = shoppingData[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

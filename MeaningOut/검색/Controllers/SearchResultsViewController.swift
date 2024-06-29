//
//  SearchResultsViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit
import Alamofire


class SearchResultsViewController: BaseViewController {
    
    var searchResult: String = ""
    var searchResultCount: Int = 0 {
        didSet {
            updateSearchtotal()
        }
    }
    
    var sortType: SortType = .accuracy
    
    // 페이지네이션
    var page = 1
    
    // 현재 선택된 버튼 저장
    var selectedButton: UIButton?
    
    var shoppingData: [Items] = []
    
    let formatter = NumberFormatter()
    
    let searchResultView = ShoppingSearchResultsView()
    
    
    // MARK: - life cycle
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingDataReqeust()
        setUpAddTarget()
    }
    
    func shoppingDataReqeust() {
        
        ShoppingRequest.shared.shoppingService(query: searchResult, sortText: "sim") { shopping in
            if self.page == 1 {
                self.shoppingData = shopping.items
                //                self.searchResultView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            } else {
                self.shoppingData.append(contentsOf: shopping.items)
            }
            
            self.searchResultCount = shopping.total
            self.searchResultView.collectionView.reloadData()
            
            //            if self.page == 1 {
            //                self.searchResultView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            //            }
        }
    }
    
    
    // MARK: - SetUpAddTarget
    
    func setUpAddTarget() {
        searchResultView.accuracyButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        searchResultView.dateButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        searchResultView.descendingButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        searchResultView.ascendingButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    
    
    @objc func sortButtonTapped(_ sender: UIButton) {
        print("돼")
        switch sender {
        case searchResultView.dateButton:
            sortType = .date
        case searchResultView.accuracyButton:
            sortType = .accuracy
        case searchResultView.descendingButton:
            sortType = .descending
        case searchResultView.ascendingButton:
            sortType = .ascending
        default:
            break
        }
        
        shoppingSort()
    }
    
    func shoppingSort() {
        let group = DispatchGroup()
        group.enter()
        switch sortType {
        case .accuracy:
            ShoppingRequest.shared.shoppingService(query: searchResult, sortText: "sim") { shopping in
                self.shoppingData = shopping.items
                print("accurary")
                group.leave()
            }
        case .date:
            ShoppingRequest.shared.shoppingService(query: searchResult, sortText: "date") { shopping in
                self.shoppingData = shopping.items
                group.leave()
            }
        case .descending:
            ShoppingRequest.shared.shoppingService(query: searchResult, sortText: "dsc") { shopping in
                self.shoppingData = shopping.items
                group.leave()
            }
        case .ascending:
            ShoppingRequest.shared.shoppingService(query: searchResult, sortText: "asc") { shopping in
                self.shoppingData = shopping.items
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.searchResultView.collectionView.reloadData()
        }
    }
    
    func updateButtonState(button: UIButton) {
        guard button != selectedButton else { return } // 이미 선택된 버튼이면 리턴
        
        // 선택된 버튼의 색상 변경
        button.backgroundColor = .customDarkGray
        button.setTitleColor(.white, for: .normal)
        
        // 이전에 선택된 버튼의 색상 원래대로 변경
        selectedButton?.backgroundColor = .white
        selectedButton?.setTitleColor(.black, for: .normal)
        
        // 선택된 버튼 업데이트
        selectedButton = button
    }
    
    // MARK: - 기능
    
    func updateSearchtotal() {
        
        let count = Int(searchResultCount)

        formatter.numberStyle = .decimal // 3자리마다 콤마를 추가하는 형식
        
        if let result = formatter.string(for: count) {
            let boldText = "상품"
            let normalText = result
            
            // 볼드체 텍스트와 일반 텍스트를 NSAttributedString으로 변환
            guard let font = FontType.pretendardMedium.pretendardFont(ofsize: 16) else { return }
            let attributedString = NSMutableAttributedString(string: boldText, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black.cgColor ])
                  attributedString.append(NSAttributedString(string: " " + normalText))
                  
                  // searchResultLabel에 적용
                  searchResultView.searchResultLabel.attributedText = attributedString
              }
//            searchResultView.searchResultLabel.text = "상품 " + result
        
    }
    
    // MARK: - View
    
    
    override func configureView() {
        super.configureView()

        navigationItem.title = searchResult
        navigationItem.backButtonTitle = "상품 목록"
        
        searchResultView.collectionView.delegate = self
        searchResultView.collectionView.dataSource = self
        searchResultView.collectionView.prefetchDataSource = self
        searchResultView.collectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
    }
    
    
}


// MARK: - CollectionView Delegate, DataSource

extension SearchResultsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if shoppingData.count - 2 == item.row {
                page += 1
                shoppingDataReqeust()
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
        cell.likeButton.tag = indexPath.row
        
        cell.index = indexPath.row
        
        //        if likeStatuses[indexPath.row].isLiked == true {
        //            cell.isTouched = true
        //        } else {
        //            cell.isTouched = false
        //        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = DetailProductViewController()
        vc.link = shoppingData[indexPath.row].link
        vc.productName = shoppingData[indexPath.row].title
        //        vc.likeButtonType = likeStatuses[indexPath.row].isLiked
        print(vc.likeButtonType)
        navigationController?.pushViewController(vc, animated: true)
    }
}

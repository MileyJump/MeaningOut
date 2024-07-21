//
//  SearchResultsViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit
import Alamofire
import RealmSwift


class SearchResultsViewController: BaseViewController {
    
    let realm = try! Realm() // 렘 주소 알려고 해놓음!
    
    let repository = ShoppingTableRepository()

    var searchResult: String = ""
    var searchResultCount: Int = 0 {
        didSet {
            updateSearchtotal()
        }
    }
    
    var searchWord: [String] = []
    var sortType: SortType = .accuracy
    
    // 페이지네이션
    var page = 1
    
    
    var shoppingData: [Items] = []
    
    
    let formatter = NumberFormatter()
    
    let searchResultView = ShoppingSearchResultsView()
    
    var delegate: SearchwordProfotocl?
    
    
    
    // MARK: - life cycle
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingDataReqeust()
        setUpAddTarget()
        print(realm.configuration.fileURL)
    }
    
    func shoppingDataReqeust() {
        
        ShoppingRequest.shared.shoppingService(query: searchResult, sortText: "sim") { shopping in
            if self.page == 1 {
                self.shoppingData = shopping.items
                print("추가")
            } else {
                self.shoppingData.append(contentsOf: shopping.items)
            }
            
            self.searchResultCount = shopping.total
            self.searchResultView.collectionView.reloadData()
            print("리로드")
            
            
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
    }
    
    // MARK: - View
    
    
    override func configureView() {
        super.configureView()

//        navigationItem.title = searchResult
        navigationItem.titleView = searchResultView.searchBar
        navigationItem.backButtonTitle = "상품 목록"
        
        searchResultView.searchBar.delegate = self
        searchResultView.collectionView.delegate = self
        searchResultView.collectionView.dataSource = self
        searchResultView.collectionView.prefetchDataSource = self
        searchResultView.collectionView.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultsCollectionViewCell.identifier)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        print(#function)
        print(sender.tag)
        
        
        let data = shoppingData[sender.tag]
        let likeItemList = LikeItemTable(productId: data.productId, title: data.title, link: data.link, image: data.image, lprice: data.lprice, mallName: data.mallName)
        
        if let existingItem = repository.fetchLikeItem(id: data.productId) {
            repository.deleteItem(likeItem: existingItem)
            print("\(data.productId)의 상품의 찜이 취소 되었습니다~")
        } else {
            repository.createItem(likeItem: likeItemList)
            print("\(data.productId)의 상품을 찜 했습니다!")
        }
        searchResultView.collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
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
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        if repository.fetchLikeItem(id: shoppingData[indexPath.row].productId) != nil {
            cell.likeButton.tintColor = .red
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell.likeButton.tintColor = .white
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = DetailProductViewController()
        vc.link = shoppingData[indexPath.row].link
        vc.productName = shoppingData[indexPath.row].title
        print(vc.likeButtonType)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("여기야 여기")
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text else { return }
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedText.isEmpty {
            searchWord.insert(text, at: 0)
            searchResult = text
            shoppingDataReqeust()
            delegate?.searchwordDelegate(searchwrod: text)
            
        } else {
            print(#function, "검색어를 입력하세요")
        }
    }
}

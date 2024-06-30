//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

protocol SearchwordProfotocl {
    func searchwordDelegate(searchwrod: String)
}

class ShoppingSearchViewController: BaseViewController, SearchwordProfotocl {
    
    
    
    // MARK: - Properties
    
    let shoppingSearchView = ShoppingSearchView()
    
    var nickname = UserDatas.shared.nickname
    
    var searchWord: [String] = [] {
        didSet {
            searchWordState() // searchWord 변경 될때마다 호출
        }
    }
    
    // MARK: - life cycle
    
    override func loadView() {
        view = shoppingSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddTarget()
        loadSearchWords()
    }
    
    func searchwordDelegate(searchwrod: String) {
        self.searchWord.append(searchwrod)
        shoppingSearchView.searchTableView.reloadData()
        print(searchWord)
    }
    
    // MARK: - SetUpAddTarget
    
    private func setUpAddTarget() {
        shoppingSearchView.alldeleteButton.addTarget(self, action: #selector(alldeleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func alldeleteButtonTapped() {
        searchWord.removeAll()
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        searchWord.remove(at: sender.tag)
    }
    
    
    // MARK: - Method
    
    private func searchWordState() {
        let isEmpty = searchWord.isEmpty
        shoppingSearchView.emptyImageView.isHidden = !isEmpty
        shoppingSearchView.emptyLabel.isHidden = !isEmpty
        shoppingSearchView.emptyDescripsionLabel.isHidden = !isEmpty
        shoppingSearchView.alldeleteButton.isHidden = isEmpty
        shoppingSearchView.recentsearchLabel.isHidden = isEmpty
        shoppingSearchView.searchTableView.reloadData()
        
        UserDatas.shared.shoppingSearchKeyword = searchWord
    }
    
    private func loadSearchWords() {
        if let keyword = UserDatas.shared.shoppingSearchKeyword {
            searchWord = keyword
        }
    }
    
    // MARK: - ConfigureView
    
    override func configureView() {
        
        guard let nickname = nickname else { return }
        //        navigationItem.title = "\(nickname)님의 TrendyStyle"
        //        navigationItem.title = "TrendyStyle"
        navigationItem.backButtonTitle = ""
        // 타이틀 라벨 생성
        let titleLabel = UILabel()
        titleLabel.text = "TrendyStyle"
        if let customFont = FontType.pretendardBold.pretendardFont(ofsize: 20) {
            titleLabel.font = customFont
        }
        titleLabel.textColor = .customMainColor
        titleLabel.sizeToFit() // 라벨 크기에 맞게 조정
        
        
        // 네비게이션 아이템에 타이틀 라벨을 설정
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        
        navigationItem.rightBarButtonItem = search
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        
        shoppingSearchView.searchTableView.separatorStyle = .none
        shoppingSearchView.searchTableView.delegate = self
        shoppingSearchView.searchTableView.dataSource = self
        shoppingSearchView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
//        shoppingSearchView.searchBar.delegate = self
        
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        if let customFont = FontType.pretendardBold.pretendardFont(ofsize: 20) {
            appearance.titleTextAttributes = [.font : customFont, .foregroundColor: UIColor.customMainColor]
        }
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchResultsViewController()
        vc.searchWord = searchWord
        vc.delegate = self
//        let searchKeyword = searchWord[indexPath.row]
//        vc.searchResult = searchKeyword
        
        // 선택한 검색어 최근 검색어로 올리기
//        searchWord.remove(at: indexPath.row)
//        searchWord.insert(searchKeyword, at: 0)
        
        navigationController?.pushViewController(vc, animated: true)
//        tableView.reloadData()
    }
}


// MARK: - tableViewDelegate, DataSource


extension ShoppingSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier , for: indexPath) as? SearchTableViewCell else { fatalError("SearchTableViewCell 다운캐스팅 실패") }
        
        cell.configureCell(searchWord[indexPath.row])
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        let vc = SearchResultsViewController()
        let searchKeyword = searchWord[indexPath.row]
        vc.searchResult = searchKeyword
        
        // 선택한 검색어 최근 검색어로 올리기
        searchWord.remove(at: indexPath.row)
        searchWord.insert(searchKeyword, at: 0)
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
    }
}

// MARK: - SearchBar Delegate

//extension ShoppingSearchViewController: UISearchBarDelegate {
//    
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        print("여기야 여기")
//        return true
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print(#function)
//        guard let text = searchBar.text else { return }
//        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
//        if !trimmedText.isEmpty {
//            searchWord.insert(text, at: 0)
//            shoppingSearchView.searchTableView.reloadData()
//            let vc = SearchResultsViewController()
//            vc.searchResult = text
//            navigationController?.pushViewController(vc, animated: true)
//            searchBar.text = ""
//        } else {
//            print(#function, "검색어를 입력하세요")
//        }
//    }
//}


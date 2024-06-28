//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class ShoppingSearchViewController: BaseViewController {
    
    var nickname = UserDefaults.standard.string(forKey: "nickname")
    
    var searchWord: [String] = [] {
        didSet {
            searchWordState() // searchWord 변경 될때마다 호출
        }
    }
    
    let shoppingSearchView = ShoppingSearchView()
    
    
    // MARK: - life cycle

    override func loadView() {
        view = shoppingSearchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddTarget()
        loadSearchWords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
    
    
    // MARK: - 기능
    
    private func searchWordState() {
        let isEmpty = searchWord.isEmpty
        shoppingSearchView.emptyImageView.isHidden = !isEmpty
        shoppingSearchView.emptyLabel.isHidden = !isEmpty
        shoppingSearchView.searchTableView.reloadData()
        
        UserDefaults.standard.set(searchWord, forKey: "keyword")
    }
    
    private func loadSearchWords() {
        if let keyword = UserDefaults.standard.stringArray(forKey: "keyword") {
            searchWord = keyword
        }
    }
    
    // MARK: - view 구성
     override func configureView() {
        view.backgroundColor = .white
        
        
        guard let nickname = nickname else { return }
        navigationItem.title = "\(nickname)님의 MEANING OUT"
        navigationItem.backButtonTitle = ""
        
        
        shoppingSearchView.searchTableView.separatorStyle = .none
        shoppingSearchView.searchTableView.delegate = self
        shoppingSearchView.searchTableView.dataSource = self
        shoppingSearchView.searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        shoppingSearchView.searchBar.delegate = self
    }
    
   
}


// MARK: - tableViewDelegate, DataSource


extension ShoppingSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier , for: indexPath) as! SearchTableViewCell
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
        
        searchWord.remove(at: indexPath.row)
        searchWord.insert(searchKeyword, at: 0)
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
    }
}

// MARK: - SearchBar Delegate

extension ShoppingSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            searchWord.insert(text, at: 0)
            shoppingSearchView.searchTableView.reloadData()
        }
        
        let vc = SearchResultsViewController()
        vc.searchResult = text
        navigationController?.pushViewController(vc, animated: true)
        searchBar.text = ""
    }
    
}


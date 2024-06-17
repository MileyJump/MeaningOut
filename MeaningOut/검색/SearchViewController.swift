//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    var nickname = UserDefaults.standard.string(forKey: "nickname")
    
    var searchWord: [String] = [] {
        didSet {
            searchWordState() // searchWord 변경 될때마다 호출
        }
    }
    
    // MARK: - UI

    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let searBarImage = UIImage()
        searchBar.backgroundImage = searBarImage
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        searchBar.searchTextField.font = .systemFont(ofSize: 15)
        return searchBar
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    let recentsearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let alldeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.customMainColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    
    let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "empty")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어가 없어요"
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - life cycle


    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
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
    
    
    func setUpAddTarget() {
        alldeleteButton.addTarget(self, action: #selector(alldeleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func alldeleteButtonTapped() {
        searchWord.removeAll()
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        searchWord.remove(at: sender.tag)
    }
    
    
    // MARK: - 기능
    
    func searchWordState() {
        let isEmpty = searchWord.isEmpty
        emptyImageView.isHidden = !isEmpty
        emptyLabel.isHidden = !isEmpty
        searchTableView.reloadData()
        
        UserDefaults.standard.set(searchWord, forKey: "keyword")
    }
    
    func loadSearchWords() {
        if let keyword = UserDefaults.standard.stringArray(forKey: "keyword") {
            searchWord = keyword
        }
    }
    
    // MARK: - view 구성
    func configureView() {
        view.backgroundColor = .white
        
        
        guard let nickname = nickname else { return }
        navigationItem.title = "\(nickname)님의 MEANING OUT"
        navigationItem.backButtonTitle = ""
        
        
        searchTableView.separatorStyle = .none
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        searchBar.delegate = self
    }
    
    // MARK: - 레이아웃
    
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(lineView)
        view.addSubview(recentsearchLabel)
        view.addSubview(alldeleteButton)
        view.addSubview(emptyImageView)
        view.addSubview(emptyLabel)
        view.addSubview(searchTableView)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }

        recentsearchLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalTo(lineView.snp.bottom).offset(15)
        }
        
        alldeleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(recentsearchLabel)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }

        emptyImageView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(emptyImageView.snp.width).multipliedBy(1)
        }

        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(emptyImageView)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }

        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(recentsearchLabel.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


// MARK: - tableViewDelegate, DataSource


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text else { return }
        
        if !text.isEmpty {
            searchWord.insert(text, at: 0)
            searchTableView.reloadData()
        }
        
        let vc = SearchResultsViewController()
        vc.searchResult = text
        navigationController?.pushViewController(vc, animated: true)
        searchBar.text = ""
    }
    
}


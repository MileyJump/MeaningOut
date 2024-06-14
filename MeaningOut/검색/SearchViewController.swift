//
//  SearchViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    var nickname = UserDefaults.standard.string(forKey: "nickname")
    
    var searchWord: [String] = []
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let searBarImage = UIImage()
        searchBar.backgroundImage = searBarImage
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureHierarchy()
        configureLayout()
    }
    

    func configureView() {
        view.backgroundColor = .white
        
        guard let nickname = nickname else { return }
        navigationItem.title = "\(nickname)'s MEANING OUT"
        print(nickname)
        
        searchTableView.separatorStyle = .none
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
        searchBar.delegate = self
        
       
    }
    
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier , for: indexPath) as! SearchTableViewCell
        
        
        cell.configureCell(searchWord[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text else { return }
        
        searchWord.append(text)
        searchTableView.reloadData()
    }
    
}

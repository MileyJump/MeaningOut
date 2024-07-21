//
//  ShoppingSearchResultsView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit

class ShoppingSearchResultsView: BaseView {
    // MARK: - UI
    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
       let searBarImage = UIImage()
       searchBar.backgroundImage = searBarImage
       searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
       searchBar.autocorrectionType = .no
       searchBar.spellCheckingType = .no
       searchBar.searchTextField.font = .systemFont(ofSize: 15)
//         searchBar.isHidden = true
       return searchBar
   }()
 
    
    lazy var searchResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customLightGray
        label.font = FontType.pretendardMedium.pretendardFont(ofsize: 14)
        return label
    }()
    
    lazy var accuracyButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: SortType.accuracy.title, cornerRadius: 16)
        return button
    }()
    
    lazy var dateButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: SortType.date.title, cornerRadius: 16)
        return button
    }()
    
    lazy var descendingButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: SortType.descending.title, cornerRadius: 16)
        return button
    }()
    
    lazy var ascendingButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: SortType.ascending.title, cornerRadius: 16)
        return button
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.collectionViewLayout())
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - 레이아웃
    
    override func configureHierarchy() {
        addSubview(searchResultLabel)
        addSubview(accuracyButton)
        addSubview(dateButton)
        addSubview(descendingButton)
        addSubview(ascendingButton)
        addSubview(collectionView)
    }
    
    
    override func configureLayout() {
        
        searchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
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
        
        descendingButton.snp.makeConstraints { make in
            make.height.verticalEdges.equalTo(accuracyButton)
            make.width.equalTo(80)
            make.leading.equalTo(dateButton.snp.trailing).offset(10)
        }
        
        ascendingButton.snp.makeConstraints { make in
            make.size.verticalEdges.equalTo(descendingButton)
            make.leading.equalTo(descendingButton.snp.trailing).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(accuracyButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}

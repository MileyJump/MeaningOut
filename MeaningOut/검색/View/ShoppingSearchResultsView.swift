//
//  ShoppingSearchResultsView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit

class ShoppingSearchResultsView: BaseView {
    // MARK: - UI
    
    lazy var searchResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customMainColor
//        label.text = "\(searchResultCount)개의 검색 결과"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var accuracyButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "정확도", cornerRadius: 16)
//        button.addTarget(self, action: #selector(accuracyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var dateButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "날짜순", cornerRadius: 16)
//        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var highPriceButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "가격높은순", cornerRadius: 16)
//        button.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var lowestPriceButton: UIButton = {
        let button = UIButton()
        button.configureButton(title: "가격낮은순", cornerRadius: 16)
//        button.addTarget(self, action: #selector(lowestPriceButtonTapped), for: .touchUpInside)
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - 레이아웃
    
    override func configureHierarchy() {
        addSubview(searchResultLabel)
        addSubview(accuracyButton)
        addSubview(dateButton)
        addSubview(highPriceButton)
        addSubview(lowestPriceButton)
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
        
        highPriceButton.snp.makeConstraints { make in
            make.height.verticalEdges.equalTo(accuracyButton)
            make.width.equalTo(80)
            make.leading.equalTo(dateButton.snp.trailing).offset(10)
        }
        
        lowestPriceButton.snp.makeConstraints { make in
            make.size.verticalEdges.equalTo(highPriceButton)
            make.leading.equalTo(highPriceButton.snp.trailing).offset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(accuracyButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}

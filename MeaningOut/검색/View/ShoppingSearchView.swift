//
//  ShoppingSearchView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit

class ShoppingSearchView: BaseView {
    
    // MARK: - UI
    
    private let lineView: UIView = {
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
//        imageView.image = UIImage(named: "empty")
        imageView.image = UIImage(named: "heartHand")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
     let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어 내역이 없어요"
         label.font = FontType.pretendardSemiBold.pretendardFont(ofsize: 16)
        label.textAlignment = .center
        return label
    }()
    let emptyDescripsionLabel: UILabel = {
        let label = UILabel()
        label.text = "원하는 상품을 검색해 보세요!"
         label.font = FontType.pretendardMedium.pretendardFont(ofsize: 13)
        label.textColor = .customMediumGray
        label.textAlignment = .center
        return label
    }()
    
    
    
     let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - 레이아웃
    
    override func configureHierarchy() {
//        addSubview(searchBar)
        addSubview(lineView)
        addSubview(recentsearchLabel)
        addSubview(alldeleteButton)
        addSubview(emptyImageView)
        addSubview(emptyLabel)
        addSubview(emptyDescripsionLabel)
        addSubview(searchTableView)
    }
    
    override func configureLayout() {
//        searchBar.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide)
//            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(5)
////            make.height.equalTo(40)
//        }
        
        lineView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom).offset(3)
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
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
            make.centerY.equalTo(safeAreaLayoutGuide).offset(-30)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(50)
            make.height.equalTo(emptyImageView.snp.width).multipliedBy(1)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(emptyImageView)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        emptyDescripsionLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(emptyLabel)
            make.centerX.equalTo(emptyLabel)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(recentsearchLabel.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}



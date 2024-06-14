//
//  SearchView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class SearchView: UIView {
    
    let recentsearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.font = .boldSystemFont(ofSize: 13)
//        label.backgroundColor = .red
        return label
    }()
    
    let alldeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.customMainColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
//        button.backgroundColor = .purple
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        self.addSubview(recentsearchLabel)
        self.addSubview(alldeleteButton)
    }
    
    func configureLayout() {
        recentsearchLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        alldeleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(30)
            
        }
    }
}

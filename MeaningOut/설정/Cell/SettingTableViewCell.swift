//
//  SettingTableViewCell.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 장바구니 목록"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "like_selected")
        return imageView
    }()
 
    let productLabel: UILabel = {
        let label = UILabel()
        label.text = "0개의 상품"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - cell 구성
    
    func configureCell() {
        let likeCount = UserDefaults.standard.integer(forKey: "like")
        productLabel.text = "\(likeCount)개의 상품"
    }
    
    // MARK: - 레이아웃
    
    func configureHierarchy() {
        contentView.addSubview(settingLabel)
        contentView.addSubview(likeImageView)
        contentView.addSubview(productLabel)
    }
    
    func configureLayout() {
        settingLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(15)
            make.height.equalTo(30)
        }
        
        productLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(settingLabel)
            make.trailing.equalToSuperview().inset(15)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(settingLabel)
            make.trailing.equalTo(productLabel.snp.leading).offset(-3)
            make.size.equalTo(22)
        }
    }
    
    
    
}

//
//  LikeCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최민경 on 7/20/24.
//

import Foundation
import UIKit

class LikeCollectionViewCell: UICollectionViewCell {
    
    let shoppingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "네이버"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .customLightGray
        label.textAlignment = .left
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1,564,000원"
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - UI
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
//        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shoppingImageView.layer.cornerRadius = 4
        shoppingImageView.clipsToBounds = true
    }
    

    
    // MARK: - 셀 구성
    
    
    func configureCell(_ data: LikeItemTable) {
        let url = URL(string: data.image)
        shoppingImageView.kf.setImage(with: url)
        
        titleLabel.text = data.mallName
        subTitleLabel.text = data.title
        priceLabel.text = data.lprice
    }
    
    // MARK: - 레이아웃
    
    func configureHierarchy() {
        contentView.addSubview(shoppingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
    }
    
    func configureLayout() {
        shoppingImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(shoppingImageView.snp.width).multipliedBy(1.2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(shoppingImageView)
            make.top.equalTo(shoppingImageView.snp.bottom).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(shoppingImageView)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(shoppingImageView)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(shoppingImageView.snp.trailing).inset(5)
            make.bottom.equalTo(shoppingImageView.snp.bottom).inset(5)
            make.size.equalTo(35)
        }
        
    }
    
}

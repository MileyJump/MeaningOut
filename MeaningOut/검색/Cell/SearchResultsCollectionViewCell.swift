//
//  SearchResultsCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit
import Kingfisher

protocol likeButtonDelegate {
    func didlikeButton(for index:Int, like:Bool)
}

class SearchResultsCollectionViewCell: UICollectionViewCell {
    
//    var delegate: likeButtonDelegate?
    
    // MARK: - UI
    
    let formatter = NumberFormatter()
    
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
    
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
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
    
    
    func configureCell(_ data: Items) {
        let url = URL(string: data.image)
        shoppingImageView.kf.setImage(with: url)
        titleLabel.text = data.mallName
  
        let titleWithTags = data.title
           
           let font = UIFont.systemFont(ofSize: 15)
           let defaultColorHex = "#000000" // Black color
           let tagColorHex = "#FF0000" // Red color
           
           if let attributedString = titleWithTags.htmlToAttributedString(defaultFont: font, defaultColorHex: defaultColorHex, tagColorHex: tagColorHex) {
               subTitleLabel.attributedText = attributedString
           } else {
               subTitleLabel.text = data.title
           }
        
        
        if let price = Int(data.lprice) {
            
            formatter.numberStyle = .decimal // 3자리마다 콤마를 추가하는 형식
            
            if let result: String = formatter.string(for: price) {
                priceLabel.text = result + "원"
            }
        }
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

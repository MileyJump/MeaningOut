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
    
    var delegate: likeButtonDelegate?
    var index: Int?
    
    
    let shoppingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
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
        label.text = "아이폰 15 프로 256GB 우리집 강아지 해피는 너무너무 귀여워 포메라니안 최고야 아주 귀여워"
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
//        let likeImage = mylike ? "like_unselected" : "like_unselected"
        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.backgroundColor = .customMediumGray.withAlphaComponent(0.3)
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
    
    // MARK: - 기능
    
    func didlikeButton(_ sender: UIButton) {
            guard let index = index else {return}
            if sender.isSelected {
                isTouched = true
                delegate?.didlikeButton(for: index, like: true)
            }else {
                isTouched = false
                delegate?.didlikeButton(for: index, like: false)
            }
            sender.isSelected = !sender.isSelected
        }
        
        var isTouched: Bool? {
            didSet {
                if isTouched == true {
                    likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
                }else{
                    likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
                }
            }
        }
        
    // MARK: - 셀 구성
    
    
    func configureCell(_ data: Items) {
        let url = URL(string: data.image)
        shoppingImageView.kf.setImage(with: url)
        
        titleLabel.text = data.mallName
        subTitleLabel.text = data.title
    
        if let price = Int(data.lprice) {
            let formatter = NumberFormatter()
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
            make.height.equalTo(shoppingImageView.snp.width).multipliedBy(1.3)
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
            make.trailing.equalTo(shoppingImageView.snp.trailing).inset(10)
            make.bottom.equalTo(shoppingImageView.snp.bottom).inset(15)
            make.size.equalTo(35)
        }
        
    }
    
}

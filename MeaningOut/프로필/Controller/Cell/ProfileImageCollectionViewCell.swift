//
//  ProfileImageCollectionViewCell.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    var alphaResult: CGFloat = 0.5
    
    // MARK: - UI

    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureImageView(backgroundColor: .clear, borderWidth: 3, borderColor: UIColor.lightGray.cgColor)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "profile_2")
        imageView.layer.cornerRadius = contentView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.alpha = alphaResult
        return imageView
    }()
    
    // MARK: - life cycle

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 셀 구성

    
    func configureCell(_ data: String, isSelected: Bool) {
        profileImageView.image = UIImage(named: data)
        profileImageView.alpha = isSelected ? 1.0 : 0.5 
        profileImageView.layer.borderColor = isSelected ? UIColor.customMainColor.cgColor : UIColor.lightGray.cgColor
    }
    
    
    // MARK: - 레이아웃

    
    func configureHierarchy() {
        contentView.addSubview(profileImageView)
        
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

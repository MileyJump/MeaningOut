//
//  ProfileSelectView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit

class ProfileSelectView: BaseView {
    // MARK: - UI
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
//                imageView.image = UIImage(named: profileImage) // profileVC 이미지뷰 표시
                imageView.image = UIImage(systemName: "star")
        imageView.configureImageView(backgroundColor: .clear, borderWidth: 3, borderColor: UIColor.customMainColor.cgColor)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true

        return imageView
    }()
    
    let cameraButton: UIButton = {
        let button = UIButton()
        button.cameraButton()
        return button
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // cornerRadius : 프로필 카메라 원형으로 레이아웃 잡기
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
    }

    
    
    // MARK: - 레이아웃 구성
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(cameraButton)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(snp.width).multipliedBy(0.25)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        
    }
}

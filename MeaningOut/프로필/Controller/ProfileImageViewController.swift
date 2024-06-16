//
//  ProfileImageViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class ProfileImageViewController: UIViewController {
    
    
    var delegate: ImageUpdateDelegate?
    
    var navibartitle: String = ""
    var profileImage: String = ""
    
    var imageData: [Profile] = ProfileInfo().profile
    
    // MARK: - UI
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: profileImage) // profileVC 이미지뷰 표시
        imageView.configureImageView(backgroundColor: .clear, borderWidth: 3, borderColor: UIColor.customMainColor.cgColor)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let cameraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.backgroundColor = .customMainColor
        button.imageView?.contentMode = .scaleAspectFit // 이미지를 버튼 크기에 맞게 조절하기 위해
        
        // 이미지 여백 설정
        let inset: CGFloat = 6
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
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
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    // cornerRadius : 프로필 카메라 원형으로 레이아웃 잡기
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
    }
    
    
    // MARK: - 뷰 구성, 컬렉션뷰

    func configureView() {
        view.backgroundColor = .white
        navigationItem.title = navibartitle
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
    }
    
    // MARK: - 레이아웃 구성
    
    func configureHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(cameraButton)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(view.snp.width).multipliedBy(0.25)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
}

// MARK: - 컬렉션뷰

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier , for: indexPath) as! ProfileImageCollectionViewCell
        cell.configureCell(imageData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        profileImage = imageData[indexPath.row].image_name
        profileImageView.image = UIImage(named: profileImage)
        delegate?.didUpdateImage(profileImage)
        
    }
    
    
}

//
//  ProfileImageViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

class ProfileSelectViewController: BaseViewController {
    
    private let profileSelectView = ProfileSelectView()
    
    
    var delegate: ImageUpdateDelegate?
    
    var navibartitle: String = ""
    var profileImage: String = ""
    
    var selectedIndexPath: IndexPath?
    
   
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = profileSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    
    
    // MARK: - 뷰 구성, 컬렉션뷰

    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = navibartitle
        
        profileSelectView.collectionView.dataSource = self
        profileSelectView.collectionView.delegate = self
        profileSelectView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
        profileSelectView.profileImageView.image = UIImage(named: profileImage)
    }
}

// MARK: - 컬렉션뷰

extension ProfileSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileImageType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier , for: indexPath) as! ProfileImageCollectionViewCell
        let isSelected = indexPath == selectedIndexPath
        cell.configureCell(ProfileImageType.allCases[indexPath.row].rawValue, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        profileImage = ProfileImageType.allCases[indexPath.row].rawValue
        profileSelectView.profileImageView.image = UIImage(named: profileImage)
        delegate?.didUpdateImage(profileImage)
    

        // 이전에 선택된 셀이 있으면 리로드하여 원래 상태로 되돌림
        if selectedIndexPath != nil {
            collectionView.reloadData()
        }
        // 새로 선택된 셀의 인덱스를 저장하고 리로드
        selectedIndexPath = indexPath
        collectionView.reloadItems(at: [indexPath])
        
    }
}

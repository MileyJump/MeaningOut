//
//  LikeViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/29/24.
//

import UIKit

class LikeViewController: BaseViewController {
    
    let repository = ShoppingTableRepository()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.collectionViewLayout())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "찜"
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        
        navigationItem.rightBarButtonItem = search
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        collectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: LikeCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func searchButtonTapped() {
        let vc = SearchResultsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
}

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.fetchLikeitem().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCollectionViewCell.identifier, for: indexPath) as? LikeCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(repository.fetchLikeitem()[indexPath.row])
        return cell
    }
    
    
    
}

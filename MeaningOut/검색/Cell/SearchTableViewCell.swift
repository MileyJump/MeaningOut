//
//  SearchTableViewCell.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit


class SearchTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.tintColor = .black
        return imageView
    }()
    
    let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "맥북 거치대"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // MARK: - life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - cell 구성
    
    func configureCell(_ text: String) {
        searchLabel.text = text
    }
    
    // MARK: - 레이아웃
    
    func configureHierarchy() {
        contentView.addSubview(clockImageView)
        contentView.addSubview(searchLabel)
        contentView.addSubview(deleteButton)
    }
    
    func configureLayout() {
        clockImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(10)
            make.size.equalTo(18)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.centerY.equalTo(clockImageView)
            make.leading.equalTo(clockImageView.snp.trailing).offset(15)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.verticalEdges.equalToSuperview().inset(2)
            make.width.equalTo(deleteButton.snp.height)
        }
        
    }
    
    
}

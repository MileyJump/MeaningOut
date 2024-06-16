//
//  ProfileSettingTableViewCell.swift
//  MeaningOut
//
//  Created by 최민경 on 6/15/24.
//

import UIKit

class ProfileSettingTableViewCell: UITableViewCell {
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.configureImageView(backgroundColor: .clear, borderWidth: 3, borderColor: UIColor.customMainColor.cgColor)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "옹골찬 고래밥"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2024. 06. 15 가입"
        label.textColor = .customMediumGray
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .customMediumGray
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configuraUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    
    func configuraUI() {
        // 저장된 프로필 표시
        guard let profileName = UserDefaults.standard.string(forKey: "profile") else { return }
        profileImageView.image = UIImage(named: "\(profileName)")
        
        // 저장된 닉네임 표시
        guard let nickName = UserDefaults.standard.string(forKey: "nickname") else { return }
        nicknameLabel.text = nickName
        
        // 가입한 날짜 표시
        
        if let date = UserDefaults.standard.string(forKey: "JoinDate") {
            dateLabel.text = "\(date) 가입"
        }
    }
    
    func configureCell() {
       
        
    }
    
    func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(arrowImageView)
        
    }
    
    func configureLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(80)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY).offset(-10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(25)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel.snp.leading)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(profileImageView)
            make.width.equalTo(15)
            make.height.equalTo(22)
        }
    }
}

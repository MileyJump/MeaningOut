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
        guard let profileName = UserDefaults.standard.string(forKey: "profile") else { return }
        profileImageView.image = UIImage(named: "\(profileName)")
        
        guard let nickName = UserDefaults.standard.string(forKey: "nickname") else { return }
        print("=========ddd:::: \(nickName)")
        nicknameLabel.text = nickName
    }
    
    func configureCell() {
       
        
    }
    
    func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        
    }
    
    func configureLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(80)
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(25)
        }
    }
}

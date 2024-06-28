//
//  ProfileView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit

class ProfileView: BaseView {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요 :)"
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customMainColor
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let doneButton = NextButton(title: "완료")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // cornerRadius : 프로필, 카메라 이미지뷰 원형으로 레이아웃 잡기
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
    }
    
    // MARK: - 레이아웃
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(cameraButton)
        addSubview(nicknameTextField)
        addSubview(lineView)
        addSubview(nicknameLabel)
        addSubview(doneButton)
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
        
        
        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.trailing.equalTo(nicknameTextField.snp.trailing).offset(5)
            make.leading.equalTo(nicknameTextField.snp.leading).offset(-5)
            make.height.equalTo(1)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nicknameTextField)
            make.top.equalTo(lineView.snp.bottom).offset(15)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(nicknameTextField)
            make.height.equalTo(45)
            
        }
    }
    
}

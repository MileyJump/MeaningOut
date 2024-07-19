//
//  ProfileViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

protocol ImageUpdateDelegate: AnyObject {
    func didUpdateImage(_ image: String)
}

class ProfileViewController: BaseViewController, ImageUpdateDelegate {
    
    // MARK: - Properties
    
    let profileView = ProfileView()
    
    var profileType: ProfileScreenType = .setting
    
    var profileName: String = ""
    
    let viewModel = ProfileViewModel()
    
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfile()
        setUpAddTarget()
        bindData()
    }
    
    // MARK: - 타입에 따른 화면 구성
    
    override func configureView() {
        super.configureView()
        
        // 열거형 타입에 따른 네비게이션 타이틀
        navigationItem.title = profileType.rawValue
        
//        profileView.nicknameTextField.delegate = self
        profileView.nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // 완료버튼 기본으로 비활성화
        profileView.doneButton.isEnabled = false
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
           guard let text = textField.text else { return }
           viewModel.inputNickname.value = text
       }
    
    func bindData() {
        viewModel.outputNickname.bind { value in
            self.profileView.nicknameLabel.text = value
        }
        
        viewModel.outputValid.bind { value in
            self.profileView.nicknameLabel.textColor = value ? .customMainColor : .black
        }
        
        viewModel.outputButtonValid.bind { value in
            self.profileView.doneButton.isEnabled = value
        }
    }
    
    func configureProfile() {
        // UserDefaults에서 저장된 프로필 이미지 로드 또는 랜덤 이미지 설정
        let profileName = UserDatas.shared.profileImageString ?? ProfileImageType.randomProfile
        profileView.profileImageView.image = UIImage(named: profileName)
        self.profileName = profileName
        
        // 타입에 따른 화면 UI 설정
        switch profileType {
        case .setting:
            profileView.doneButton.isHidden = false
        case .edit:
            profileView.doneButton.isHidden = true
            setUpRightBarButton()
            if let nickName = UserDatas.shared.nickname {
                profileView.nicknameTextField.text = nickName
            }
        }
    }
    
    func setUpRightBarButton(){
        let save = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = save
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    // MARK: - AddTarget
    
    func setUpAddTarget() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileView.profileImageView.addGestureRecognizer(tap)
        profileView.cameraButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        
        profileView.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func saveButtonTapped() {
        // 유저 닉네임, 프로필 이미지 저장
        guard let name = profileView.nicknameTextField.text else { return }
        UserDatas.shared.nickname = name
        UserDatas.shared.profileImageString = profileName
        
        if let settingVC = navigationController?.viewControllers.first(where: { $0 is SettingViewController }) as? SettingViewController { // 네비게이션 컨트롤러의 스택에 있는 모든 뷰컨 중 첫 번째로 발견되는 SettingVC 찾기
            settingVC.updateProfileImage(profileName, nickname: name)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
  
    @objc func doneButtonTapped() {
        print(#function)
        // 유저 닉네임, 프로필 이미지 저장
        UserDatas.shared.nickname = profileView.nicknameTextField.text
        UserDatas.shared.profileImageString = profileName
        
        // 가입 날짜 저장하기
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        let now = formatter.string(from: currentDate)
        UserDatas.shared.joinDate = now
        
        // 프로필 설정 여부 저장 (온보딩, 메인화면 조건에 해당)
        UserDatas.shared.membershipStatus = true
        
        // rootVC 변경
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let rootViewController = ShoppingTabBarController()
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc func profileTapped() {
        print(#function)
        print(self.profileName)
        let vc = ProfileSelectViewController()
        vc.navibartitle = profileType.rawValue
        // 현재 랜덤 이미지를 vc 이미지뷰에도 표시
        vc.profileImage = profileName
        // 델리게이트를 통해 프로필 이미지 받아오기
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Delegate
    
    func didUpdateImage(_ image: String) {
        profileView.profileImageView.image = UIImage(named: image)
        profileName = image
    }
}

// MARK: - 닉네임 입력 설정


extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        // 텍스트가 비어있으면 lineView 색상 및 nicknameLabel 빈문자열
        if text.isEmpty {
            profileView.lineView.backgroundColor = .customLightGray
            profileView.nicknameLabel.text = ""
        } else {
            profileView.lineView.backgroundColor = .customDarkGray
        }
    }
}

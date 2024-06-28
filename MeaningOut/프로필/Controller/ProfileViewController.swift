//
//  ProfileViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

enum ProfileViewType: String {
    case setting = "PROFILE SETTING"
    case edit = "EDIT PROFILE"
}

protocol ImageUpdateDelegate: AnyObject {
    func didUpdateImage(_ image: String)
}

class ProfileViewController: BaseViewController, ImageUpdateDelegate {
    
    var profileType: ProfileViewType = .setting
    
    var profileName = ""
    
    let profileView = ProfileView()
    
    // MARK: - UI
    
   
    
    // MARK: - LifeCycle
    
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddTarget()
    }
    
    
    
    // MARK: - 타입에 따른 화면 구성

     override func configureView() {
        view.backgroundColor = .white
        profileView.nicknameTextField.delegate = self
        
        // 완료버튼 기본으로 비활성화
        profileView.doneButton.isEnabled = false
        
        // 열거형 타입에 따른 네비게이션 타이틀
        navigationItem.title = profileType.rawValue
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        
        // UserDefaults에서 저장된 프로필 이미지 로드 또는 랜덤 이미지 설정
        if UserDefaults.standard.string(forKey: "profile") != "" {
            if let savedProfileName = UserDefaults.standard.string(forKey: "profile") {
                profileName = savedProfileName
            }
            else {
                profileName = "profile_\(Int.random(in: 0...11))"
            }
            profileView.profileImageView.image = UIImage(named: profileName)
        }
        
        // 타입에 따른 화면 UI 설정
        switch profileType {
        case .setting:
            profileView.doneButton.isHidden = false
        case .edit:
            profileView.doneButton.isHidden = true
            setUpRightBarButton()
            if let nickName = UserDefaults.standard.string(forKey: "nickname") {
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
        UserDefaults.standard.set(name, forKey: "nickname")
        UserDefaults.standard.set(profileName, forKey: "profile")
        
        if let settingVC = navigationController?.viewControllers.first(where: { $0 is SettingViewController }) as? SettingViewController { // 네비게이션 컨트롤러의 스택에 있는 모든 뷰컨 중 첫 번째로 발견되는 SettingVC 찾기
            settingVC.updateProfileImage(profileName, nickname: name)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func profileTapped() {
        print(#function)
        
        let vc = ProfileSelectViewController()
        vc.navibartitle = profileType.rawValue
        // 현재 랜덤 이미지를 vc 이미지뷰에도 표시
        vc.profileImage = profileName
        // 델리게이트를 통해 프로필 이미지 받아오기
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func doneButtonTapped() {
        print(#function) 
        // 유저 닉네임, 프로필 이미지 저장
        UserDefaults.standard.set(profileView.nicknameTextField.text, forKey: "nickname")
        UserDefaults.standard.set(profileName, forKey: "profile")
        
        // 가입 날짜 저장하기
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        let now = formatter.string(from: currentDate)
        UserDefaults.standard.set(now, forKey: "JoinDate")
        
        // 프로필 설정 여부 저장 (온보딩, 메인화면 조건에 해당)
        UserDefaults.standard.set(true, forKey: "isUser")
        
        // rootVC 변경
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let rootViewController = ShoppingTabBarController()
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let special = ["@" ,"#", "$", "%"]
        
        // 새로 입력될 전체 텍스트 계산
        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        
        // 조건 확인
        var errorMessage: String?
        var isValid = true
        
        // '#' 문자 포함 여부 체크
        for item in special {
            if newText.contains(item) {
                errorMessage = "닉네임에 @,#,$,% 는 포함할 수 없어요"
                isValid = false
            }
        }
        
        // 글자 수 조건 체크
        if text.count < 2 || text.count > 10 {
            errorMessage = "2글자 이상 10글자 미만으로 설정해주세요"
            isValid = false // Done 버튼 비활성화
        }
        
        // 숫자 포함 여부 체크
        if newText.contains(where: { $0.isNumber }) { // 문자열의 각 문자를 순회하면서 문자가 숫자인지 확인
            errorMessage = "닉네임에 숫자는 포함할 수 없어요"
            isValid = false // Done 버튼 비활성화
        }
       
        // 결과 처리
        if let message = errorMessage { // errorMessage 설정 여부 확인 후 nicknameLabel 표시
            profileView.nicknameLabel.text = message
               } else {
                   profileView.nicknameLabel.text = "사용할 수 있는 닉네임이에요"
               }
        
        profileView.doneButton.isEnabled = isValid
        
        return true // 입력을 허용
    }
}





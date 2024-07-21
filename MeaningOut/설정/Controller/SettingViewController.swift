//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

enum SettingOptions: String, CaseIterable {
    case profile
    case mylikeList = "나의 장바구니 목록"
    case question = "자주 묻는 질문"
    case ask = "1:1 문의"
    case notification = "알림 설정"
    case secession = "탈퇴하기"
}

class SettingViewController: BaseViewController {
    
    let settingView = SettingView()
    private let repository = ShoppingTableRepository()
    
    // MARK: - life Cycle
    
    override func loadView() {
        view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - View, TableView 구성
    
    override func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "SETTING"
        navigationItem.backButtonTitle = ""
        
        settingView.settingTableView.delegate = self
        settingView.settingTableView.dataSource = self
        settingView.settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        settingView.settingTableView.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: ProfileSettingTableViewCell.identifier)
    }
    
    // updateProfileImage 메서드 추가
    func updateProfileImage(_ imageName: String, nickname: String) {
        // 현재 뷰컨트롤러가 보여주는 테이블뷰 셀을 업데이트
        if let profileCell = settingView.settingTableView.cellForRow(at: [0, 0]) as? ProfileSettingTableViewCell {
            profileCell.profileImageView.image = UIImage(named: imageName)
            print("업데이트 프로필 이미지 \(imageName)")
            profileCell.nicknameLabel.text = nickname
            
        }
    }
    
    
   
}

// MARK: - 테이블뷰 : Delegate, DataSource

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return SettingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = SettingOptions.allCases[indexPath.row]
        
        if settingCell == .profile {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingTableViewCell.identifier, for: indexPath) as! ProfileSettingTableViewCell
            return profileCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            if settingCell != .mylikeList {
                cell.likeImageView.isHidden = true
                cell.productLabel.isHidden = true
            }
            let likeCount = repository.fetchLikeitems().count
            cell.configureCell(likeCount: likeCount)
            cell.settingLabel.text = settingCell.rawValue
            print(settingCell.rawValue)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingCell = SettingOptions.allCases[indexPath.row]
        
        if settingCell == .profile {
            let vc = ProfileViewController()
            vc.profileType = .edit
            navigationController?.pushViewController(vc, animated: true)
        } else if settingCell == .secession {
            showAlert(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", ok: "확인") {
                resetUserDefaults()
                onboardingBegin()
            }
        }
        
        // 셀 선택될 때 색상? reload
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        
        func resetUserDefaults() {
            // 사용자 정보 초기화
            for key in UserDefaults.standard.dictionaryRepresentation().keys {
                UserDefaults.standard.removeObject(forKey: key.description)
            }
        }
        
        func onboardingBegin() {
            // 온보딩으로 초기화 RootVC
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            let rootViewController = OnboardingViewController()
            let navigationController = UINavigationController(rootViewController: rootViewController)
            sceneDelegate?.window?.rootViewController = navigationController
            sceneDelegate?.window?.makeKeyAndVisible()
        }
    }
}

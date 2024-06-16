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

class SettingViewController: UIViewController {
    
    // MARK: - UI
    
    let settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .customDarkGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    // MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        
    }
    
    // MARK: - View, TableView 구성

    func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "SETTING"
        navigationItem.backButtonTitle = ""
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        settingTableView.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: ProfileSettingTableViewCell.identifier)
    }
    
    // MARK: - 레이아웃 구성

    func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    func configureLayout() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
            cell.settingLabel.text = settingCell.rawValue
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
            let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                UserDefaults.standard.set(false, forKey: "isUser")
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let rootViewController = OnboardingViewController()
                sceneDelegate?.window?.rootViewController = rootViewController
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        }
        
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
    }
    
}

//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit

enum SettingOptions: String, CaseIterable {
    case mylikeList = "나의 장바구니 목록"
    case question = "자주 묻는 질문"
    case ask = "1:1 문의"
    case notification = "알림 설정"
    case secession = "탈퇴하기"
}

class SettingViewController: UIViewController {
    
//    var profileName = "profile_\(Int.random(in: 0...11))"
//    var nickName = UserDefaults.standard.string(forKey: "nickname")
//    var profileName = UserDefaults.standard.string(forKey: "profile")
    
    let settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .customDarkGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        settingTableView.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: ProfileSettingTableViewCell.identifier)
        
    }
    
    func configureHierarchy() {
        view.addSubview(settingTableView)
    }
    
    func configureLayout() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return SettingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingTableViewCell.identifier, for: indexPath) as! ProfileSettingTableViewCell
            
            return profileCell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            cell.settingLabel.text = SettingOptions.allCases[indexPath.row].rawValue
            
            print(#function)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = ProfileViewController()
            vc.profileType = .edit
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

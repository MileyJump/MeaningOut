//
//  SettingView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit


class SettingView: BaseView {
    // MARK: - UI
    
    let settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.separatorColor = .customDarkGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - 레이아웃 구성
    
    override func configureHierarchy() {
        addSubview(settingTableView)
    }
    
    override func configureLayout() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}

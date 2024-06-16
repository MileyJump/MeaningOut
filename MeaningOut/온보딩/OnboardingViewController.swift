//
//  ViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    let serviceName: UILabel = {
        let label = UILabel()
        label.text = "MeaningOut"
        label.textAlignment = .center
        label.textColor = .customMainColor
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    let serviceImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "launch")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    let startButton = NextButton(title: "시작하기")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        setUpAddTarget()
       
    }
    
    func setUpAddTarget() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc func startButtonTapped() {
        print(#function)
        
        if navigationController == nil {
            let vc = ProfileViewController()
            //            let navigationVC = UINavigationController(rootViewController: vc)
            //            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            //                if let window = windowScene.windows.first {
            //                    window.rootViewController = navigationVC
            //                }
            print("네비게이션 컨트롤러가 nil입니다.")
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ProfileViewController()
            vc.profileType = .setting
            navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    
    
    func configureView() {
        view.backgroundColor = .white
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        
    }
    
    func configureHierarchy() {
        view.addSubview(serviceName)
        view.addSubview(serviceImageView)
        view.addSubview(startButton)
    }
    
    func configureLayout() {
        serviceName.snp.makeConstraints { make in
            make.bottom.equalTo(serviceImageView.snp.top).offset(-20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        serviceImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(serviceImageView.snp.width).multipliedBy(1)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(45)
        }
    }

}


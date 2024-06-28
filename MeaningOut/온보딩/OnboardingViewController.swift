//
//  ViewController.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import UIKit
import SnapKit

class OnboardingViewController: BaseViewController {
    
   private let onboardingView = OnboardingView()
    
    // MARK: - life cycle
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddTarget()
    }
    
    // MARK: - SetUpAddTarget

    private func setUpAddTarget() {
        onboardingView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }

    @objc private func startButtonTapped() {
        print(#function)
            let vc = ProfileViewController()
            vc.profileType = .setting
            navigationController?.pushViewController(vc, animated: true)
    }
        
    // MARK: - View 구성

     override func configureView() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        
    }
}


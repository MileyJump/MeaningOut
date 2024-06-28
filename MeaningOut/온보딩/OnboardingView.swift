//
//  OnboardingView.swift
//  MeaningOut
//
//  Created by 최민경 on 6/28/24.
//

import UIKit
import SnapKit

class OnboardingView: BaseView {
    
    // MARK: - UI

    private let serviceName: UILabel = {
        let label = UILabel()
        label.text = "MeaningOut"
        label.textAlignment = .center
        label.textColor = .customMainColor
        label.font = FontType.pretendardBlack.pretendardFont(ofsize: 40)
        return label
    }()
    
    private let serviceImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "launch")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
     let startButton = NextButton(title: "시작하기")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func configureHierarchy() {
       addSubview(serviceName)
       addSubview(serviceImageView)
       addSubview(startButton)
   }
   
    override func configureLayout() {
       serviceName.snp.makeConstraints { make in
           make.bottom.equalTo(serviceImageView.snp.top).offset(-20)
           make.horizontalEdges.equalTo(safeAreaLayoutGuide)
       }
       
       serviceImageView.snp.makeConstraints { make in
           make.center.equalToSuperview()
           make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
           make.height.equalTo(serviceImageView.snp.width).multipliedBy(1)
       }
       
       startButton.snp.makeConstraints { make in
           make.bottom.equalTo(safeAreaLayoutGuide).inset(5)
           make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
           make.height.equalTo(45)
       }
   }
    
    
}

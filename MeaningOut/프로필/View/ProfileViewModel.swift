//
//  ProfileViewModel.swift
//  MeaningOut
//
//  Created by 최민경 on 7/9/24.
//

import Foundation

class ProfileViewModel {
    
    
    var inputNickname: Observable<String?> = Observable(nil)
    
//    var inputPassword: Observable<String?> = Observable(nil)
    
    var outputNickname = Observable("")
    
    var outputValid = Observable(false)
    var outputButtonValid = Observable(false)
    
    init() {
        print("ViewModel Init")
        inputNickname.bind { nickname in
            self.validation(text: nickname)
        }
        
//        inputPassword.bind { _ in
//            self.validation()
//        }
    }
    
    private func validation(text: String?) {
        print(text)
        guard let text = text else { return }
        
        let special = ["@" ,"#", "$", "%"]
        
        // 새로 입력될 전체 텍스트 계산
//        let newText = (text as NSString).replacingCharacters(in: range, with: string)
        
        // 조건 확인
        var errorMessage: String?
        var isValid = true
        
        // '#' 문자 포함 여부 체크
        for item in special {
            if text.contains(item) {
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
        if text.contains(where: { $0.isNumber }) { // 문자열의 각 문자를 순회하면서 문자가 숫자인지 확인
            errorMessage = "닉네임에 숫자는 포함할 수 없어요"
            isValid = false // Done 버튼 비활성화
        }
        
        // 결과 처리
        if let message = errorMessage { // errorMessage 설정 여부 확인 후 nicknameLabel 표시
            outputNickname.value = message
//            profileView.nicknameLabel.textColor = .customMainColor
            outputValid.value = true
        } else {
            outputNickname.value = "사용할 수 있는 닉네임이에요"
//            profileView.nicknameLabel.textColor = .black
            outputValid.value = false
        }
        
//        profileView.doneButton.isEnabled = isValid
        outputButtonValid.value = isValid
        
        
        
        
    }
    
}

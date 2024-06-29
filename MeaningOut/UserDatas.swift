//
//  UserData.swift
//  MeaningOut
//
//  Created by 최민경 on 6/29/24.
//

import UIKit

class UserDatas {
    
    private init() { }
    
    static let shared = UserDatas()
    
    // 회원가입 날짜
    var joinDate: String? {
        get {
            return UserDefaults.standard.string(forKey: "JoinDate")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "JoinDate")
        }
    }
    
    // 회원가입 여부 (온보딩, 메인화면 조건에 해당)
    var membershipStatus: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isUser")
        }
        set {
            return UserDefaults.standard.set(true, forKey: "isUser")
        }
    }
    
    // 닉네임 저장
    var nickname: String? {
        get {
            return UserDefaults.standard.string(forKey: "nickname")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    // 프로필 이미지 저장
    var profileImageString: String? {
        get {
            return UserDefaults.standard.string(forKey: "profile")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "profile")
        }
    }
    
    // 검색 키워드 저장
    var shoppingSearchKeyword: [String]? {
        get {
            return UserDefaults.standard.stringArray(forKey: "keyword")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "keyword")
        }
    }
    
    
    
}

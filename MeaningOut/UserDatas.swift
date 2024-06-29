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
    
    var nickname: String? {
        get {
            return UserDefaults.standard.string(forKey: "nickname")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var profileImageString: String? {
        get {
            return UserDefaults.standard.string(forKey: "profile")
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: "profile")
        }
    }
    
    
}

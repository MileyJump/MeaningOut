//
//  ProfileImageModel.swift
//  MeaningOut
//
//  Created by 최민경 on 6/14/24.
//

import Foundation

struct Profile {
    let image_name: String
}


struct ProfileInfo {
    let profile: [Profile] = [
        Profile(image_name: "profile_0"),
        Profile(image_name: "profile_1"),
        Profile(image_name: "profile_2"),
        Profile(image_name: "profile_3"),
        Profile(image_name: "profile_4"),
        Profile(image_name: "profile_5"),
        Profile(image_name: "profile_6"),
        Profile(image_name: "profile_7"),
        Profile(image_name: "profile_8"),
        Profile(image_name: "profile_9"),
        Profile(image_name: "profile_10"),
        Profile(image_name: "profile_11"),
    ]
}

//
//  SortType.swift
//  MeaningOut
//
//  Created by 최민경 on 6/29/24.
//

import UIKit

enum SortType {
    case accuracy
    case date
    case descending
    case ascending
    
    var title: String {
        switch self {
        case .accuracy:
            "정확도"
        case .date:
            "날짜순"
        case .descending:
            "가격높은순"
        case .ascending:
            "가격낮은순"
        }
    }
}

//
//  Observable.swift
//  MeaningOut
//
//  Created by 최민경 on 7/9/24.
//

import Foundation

class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didset")
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value) // 인스턴스 생성, 받자마자 실행하고 싶어서
        self.closure = closure
    }
}

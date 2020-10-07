//
//  LoginViewModel.swift
//  RxLoginExample
//
//  Created by Yeojaeng on 2020/10/07.
//

import Foundation
import RxSwift
import RxCocoa


// ViewModel: ViewController
class LoginViewModel {
    let emailTextRelay = BehaviorRelay<String>(value: "")
    let pwTextRelay = BehaviorRelay<String>(value: "")

    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailTextRelay, pwTextRelay).map { username, password in
            return username.count > 0 && username.contains("@") && username.contains(".") && password.count > 0
        }
//        return Observable.combineLatest(emailTextRelay,
//            pwTextRelay).map { username, password in
//                return username.count > 0 && username.contains("@") && username.contains(".") && password.count > 0
//        }
    }
}

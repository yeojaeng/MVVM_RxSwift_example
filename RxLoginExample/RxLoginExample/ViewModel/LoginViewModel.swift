//
//  LoginViewModel.swift
//  RxLoginExample
//
//  Created by Yeojaeng on 2020/10/07.
//

import Foundation

import RxSwift
import RxCocoa


// ViewModel for ViewController
class LoginViewModel {

    // MARK: - Properties

    let emailTextRelay: BehaviorRelay = BehaviorRelay(value: "")
    let pwTextRelay: BehaviorRelay = BehaviorRelay(value: "")

    // MARK: - Methods


    /// Check Input validation
    /// - Returns: bool type Observable
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(emailTextRelay, pwTextRelay).map { username, password in
            return username.count > 0 && username.contains("@") && username.contains(".") && password.count > 6
        }
    }
}

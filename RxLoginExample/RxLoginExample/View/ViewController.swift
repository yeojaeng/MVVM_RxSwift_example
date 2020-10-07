//
//  ViewController.swift
//  RxLoginExample
//
//  Created by Yeojaeng on 2020/10/07.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        pwTextField.isSecureTextEntry = true
        binding()
    }

    // Bind to UI
    private func binding() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.emailTextRelay)
            .disposed(by: disposeBag)

        pwTextField.rx.text
            .orEmpty
            .bind(to: viewModel.pwTextRelay)
            .disposed(by: disposeBag)

        viewModel.isValid()
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.isValid()
            .map { $0 ? 1 : 0.3 }
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)

        emailTextField.rx.text
            .orEmpty
            .subscribe(onNext: {
                print("email: \($0)")
            })
            .disposed(by: disposeBag)
        
        pwTextField.rx.text
            .orEmpty
            .subscribe(onNext: {
                print("password: \($0)")
            })
            .disposed(by: disposeBag)
        
    }
}


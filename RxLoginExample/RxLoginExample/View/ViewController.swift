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

    // MARK: - Properties

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    let viewModel: LoginViewModel = LoginViewModel()
    let disposeBag: DisposeBag = DisposeBag()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        pwTextField.isSecureTextEntry = true
        bindUI()
    }

    private func bindUI() {

        // emailTextField binding
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.emailTextRelay)
            .disposed(by: disposeBag)

        // pwTextField binding
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
    }

    private func printInput() {

        emailTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: {
                print("Email: \($0)")
            })
            .disposed(by: disposeBag)

        pwTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: {
                print("Password: \($0)")
            })
            .disposed(by: disposeBag)
    }

}

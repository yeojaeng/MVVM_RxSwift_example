//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by Yeojaeng on 2020/09/30.
//

import UIKit

protocol ViewModelBindableType {
    // VM타입은 VC에 따라 달리지기 때문에 Generic하게 선언.
    
    // associatedtype으로 여러 타입을 받을 수 있도록 선언
    associatedtype ViewModelType
    
    // 이 프로토콜을 채택하면 반드시 viewModel을 정의해야한다.
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}


extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

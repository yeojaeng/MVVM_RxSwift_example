//
//  AppCoordinator.swift
//  MVVMRxSwift
//
//  Created by Yeojaeng on 2020/10/01.
//

import Foundation
import UIKit

// Coordinator: 화면 전환을 좀 더 flexible 하게 만들어준다.

class AppCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    /// initial View를 가져와서 해당 뷰를 root로 하는 네비게이션 컨트롤러 생성
    func start() {
        let viewController = ViewController.instatinate(viewModel: RestaurantListViewModel())
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

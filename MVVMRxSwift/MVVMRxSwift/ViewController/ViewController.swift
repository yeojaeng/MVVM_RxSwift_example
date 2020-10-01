//
//  ViewController.swift
//  MVVMRxSwift
//
//  Created by Yeojaeng on 2020/10/01.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    static func instatinate() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let service = RestaurantService()
        service.fetchRestaurants().subscribe(onNext: { restaurants in
            print(restaurants)
        }).disposed(by: disposeBag)
    }
}



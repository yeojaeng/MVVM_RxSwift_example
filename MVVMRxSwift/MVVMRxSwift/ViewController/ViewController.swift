//
//  ViewController.swift
//  MVVMRxSwift
//
//  Created by Yeojaeng on 2020/10/01.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    private var viewModel: Restaurant6ListViewModel!

    static func instatinate(viewModel: RestaurantListViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView()
        
        // ListViewModel 가져와서 binding
        viewModel.fetchRestaurantViewModels()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { idx, viewModel, cell in
            cell.textLabel?.text = viewModel.displayText
        }
        .disposed(by: disposeBag)
    }
}




import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }

    var viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        binding()
    }

    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Enter GitHub ID"
        // tableView의 Headerview로 searchBar 지정
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

    private func binding() {

        // ViewModel 데이터를 테이블 뷰에 바인딩
        viewModel.data
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { _, repo, cell in
                cell.textLabel?.text = repo.repoName
                cell.detailTextLabel?.text = repo.repoURL
            }
            .disposed(by: disposeBag)

        // 서치바에 입력되는 데이터를 ViewModel의 searchText 프로퍼티에 바인딩
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        // ViewModel의 데이터의 개수를 네비게이션 바 타이틀에 바인딩
        viewModel.data
            .map { "\($0.count) Repositories" }
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }

}

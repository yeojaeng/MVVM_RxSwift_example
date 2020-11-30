

import RxSwift
import RxCocoa

// ViewModel: UI에 바인딩 할 때 처럼 VC의 데이터를 추상화하기 위한 목적.
class ViewModel {

    // MARK: - Properties
    
    // searchBar에 입력되는 데이터
    let searchText = BehaviorSubject(value: "")

    // Driver: Observable을 Wraaping하여 UI처리 목적으로 만들어짐
    lazy var data: Driver<[Repository]> = {
        return self.searchText.asObservable()
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(ViewModel.repositoriesBy(_:))
            .asDriver(onErrorJustReturn: [])
    }()
    
    // MARK: - Methods
    
    /// githubID를 전달받아 조회하여 나온 repository 반환
    /// - Parameter githubID
    /// - Returns: Repository 타입의 Observable
    static func repositoriesBy(_ githubID: String) -> Observable<[Repository]> {
        guard !githubID.isEmpty, let url = URL(string: "https://api.github.com/users/\(githubID)/repos")
        else {
            return Observable.just([])
        }
        
        return URLSession.shared.rx.json(url: url)
            .retry(3)
            .map(parse)         // json -> [Repository]
    }
    
    /// JSON 데이터를 파싱하여 Repository 타입 배열 반환
    /// - Parameter json: URLSession을 통해 받아온 json 데이터
    /// - Returns: 가공하여 만든 [Repository]
    static func parse(json: Any) -> [Repository] {
        guard let items = json as? [[String:Any]] else { return [] }
        var repositories = [Repository]()
        items.forEach {
            guard let repoName = $0["name"] as? String,
                  let repoURL = $0["html_url"] as? String else { return }
            repositories.append(Repository(repoName: repoName, repoURL: repoURL))
        }
        return repositories
    }
    
}



//
//  RestaurantService.swift
//  MVVMRxSwift
//
//  Created by Yeojaeng on 2020/10/01.
//

import Foundation
import RxSwift

// Service Protocol
protocol RestaurantServiceProtocol {
    func fetchRestaurants() -> Observable<[Restaurant]>
}


class RestaurantService: RestaurantServiceProtocol {
    
    /// restaurants.json 파일로 부터 데이터를 읽어와서 Observable<[Restaurant]> 반환
    func fetchRestaurants() -> Observable<[Restaurant]> {

        return Observable.create { observer -> Disposable in

            // JSON 데이터 경로 가져오기
            guard let path = Bundle.main.path(forResource: "restaurants", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create { }
            }
            do {
                // JSON -> Swift object
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)

                // onNext로 [Restaurant] 방출
                observer.onNext(restaurants)

            } catch(let err) {
                observer.onError(err)
            }
            return Disposables.create { }
        }
    }

}

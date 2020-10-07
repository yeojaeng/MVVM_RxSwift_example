//
//  RestaurantListViewModel.swift
//  MVVMRxSwift
//
//  Created by Yeojaeng on 2020/10/01.
//

import Foundation
import RxSwift

/// RestaurantsListView에서 사용할 뷰 모델
// 뷰모델은 뷰를 추상화한 것
final class RestaurantListViewModel {

    let title = "Restaurants"
    
    // 뷰 모델은 Service를 제공한다.
    private let restaurantService: RestaurantServiceProtocol

    init(restaurantService: RestaurantServiceProtocol = RestaurantService()) {
        self.restaurantService = restaurantService
    }
    
    /// TableView에서 보여주기 위한 뷰모델을 가져오는 함수
    func fetchRestaurantViewModels() -> Observable<[RestaurantViewModel]> {
        restaurantService.fetchRestaurants().map { $0.map { RestaurantViewModel(restaurant: $0) } }
    }
}

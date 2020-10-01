//
//  Restaurant.swift
//  MVVMRxSwift
//
//  Created by Yeojaeng on 2020/10/01.
//

import Foundation

struct Restaurant: Decodable {
    let name: String
    let cuisine: Cuisine
}

enum Cuisine: String, Decodable {
    case european
    case french
    case indian
    case english
    case mexican
}

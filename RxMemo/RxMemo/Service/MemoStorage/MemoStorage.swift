//
//  MemoStorage.swift
//  RxMemo
//
//  Created by Yeojaeng on 2020/09/30.
//

import Foundation
import RxSwift

class MemoStorage: MemoStorageType {

    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]
    
    private lazy var store = BehaviorSubject<[Memo]>(value: list)

    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let newMemo = Memo(content: content)
        list.insert(newMemo, at: 0)
        
        // subject에서 새로운 next 이벤트 방출
        store.onNext(list)
        return Observable.just(newMemo)
    }

    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updateContent: content)
        if let idx = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: idx)
            list.insert(updated, at: idx)
        }
        
        store.onNext(list)
        return Observable.just(updated)
    }

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let idx = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: idx)
        }
        
        store.onNext(list)
        return Observable.just(memo)
    }
}

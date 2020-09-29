//
//  ViewModel.swift
//  ReactorKitRestfulExample
//
//  Created by hanwe lee on 2020/09/22.
//

import UIKit
import ReactorKit
import SwiftyJSON

class ViewModel: Reactor {
    
    //MARK: outlet
    
    //MARK: property
    
    let testUrl:String = "https://reqres.in/api/users?page=2"
    var disposeBag:DisposeBag = DisposeBag()
    
    //MARK: lifeCycle
    
    enum Action {
        case startTestquery
    }
    
    enum Mutation {
        case setLoading(Bool)
        case query(JSON)
    }
    
    struct State {
        var isLoading:Bool = false
        var infoData:String = ""
        var emptyState:String = "empty"
    }
    
    let initialState: State = State()
    
    
    func mutate(action: Action) -> Observable<Mutation> { 
        switch action {
        case .startTestquery:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                self.query().map {
                    Mutation.query($0)
                },
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State { // 아마 여기는 무조건 상태만 바꿔줘야 하는듯
        var newState:State = state
        switch mutation {
        case let .setLoading(isLoading):
            if isLoading {
                print("로딩시작")
            }
            else {
                print("로딩 끝")
            }
            newState.isLoading = isLoading
        case let .query(json):
//            print("test:\(json)")
            newState.infoData = json.rawString()!
            break
        }
        return newState
    }
    
    //MARK: func
    func query() -> Observable<JSON> {
        return DataApiManager.requestGETURLRx(testUrl, headers: nil)
            .observeOn(MainScheduler.instance)
    }
    
    func display(text:String) {
        print("display:\(text)")
    }
    
    //MARK: action

}

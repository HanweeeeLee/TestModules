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
    }
    
    let initialState: State = State()
    
    
    func mutate(action: Action) -> Observable<Mutation> { //뭔가 로직은 이쪽에서 처리하는게 맞는듯
        switch action {
        case .startTestquery:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                self.query().map {
                    Mutation.query($0)
                }, // 쿼리를 어떻게 호출해줘야할까..
                Observable.just(Mutation.setLoading(false)) // 쿼리가 다 끝난다음 호출을 해주고싶음
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
        case .query:
            print("?")
            break
        }
        return newState
    }
    
    //MARK: func
    func query() -> Observable<JSON> {
        
        print("qiodhqodjoiq")
        return DataApiManager.requestGETURLRx(testUrl, headers: nil)
            .map{ json in json
                
            }.observeOn(MainScheduler.instance)
    }
    
    func display(text:String) {
        print("display:\(text)")
    }
    
    //MARK: action

}

//
//  CounterViewReactor.swift
//  reactorkitExample
//
//  Created by hanwe lee on 2020/09/17.
//

import UIKit
import ReactorKit
import RxSwift

final class CounterViewReactor: Reactor { //viewmodel인듯
    
    enum Action {
        case increase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State {
        var value:Int = 0
        var isLoading:Bool = false
    }
    
    let initialState: State = State()
    
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue)
                    .delay(1, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue)
                    .delay(1, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState:State = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
    
}

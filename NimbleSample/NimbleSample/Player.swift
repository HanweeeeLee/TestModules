//
//  Player.swift
//  NimbleSample
//
//  Created by hanwe on 2022/03/13.
//

struct Player: Equatable {
    let name: String
    var isMyTurn: Bool
    
    init(name: String) {
        self.name = name
        self.isMyTurn = false
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
}

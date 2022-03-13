//
//  Game.swift
//  NimbleSample
//
//  Created by hanwe on 2022/03/13.
//

import UIKit

class Game: NSObject {
    
    private let player1: Player
    private let player2: Player
    private let gameRepository: GameRepository
    private(set) var currentPlayPlayer: Player {
        willSet {
            self.currentPlayPlayer.isMyTurn = false
        }
        didSet {
            self.currentPlayPlayer.isMyTurn = true
        }
    }
    
    init(firstPlayPlayer: Player, secondPlayPlayer: Player, gameRepository: GameRepository) {
        self.player1 = firstPlayPlayer
        self.player2 = secondPlayPlayer
        self.currentPlayPlayer = self.player1
        self.gameRepository = gameRepository
    }
    
    private func togglePlayer() {
        if self.currentPlayPlayer == self.player1 {
            self.currentPlayPlayer = self.player2
        } else {
            self.currentPlayPlayer = self.player1
        }
    }
    
    func moveCurrentTurnPlayer() {
        print("\(self.currentPlayPlayer)의 플레이")
        print("무언가를 했다.")
        togglePlayer()
    }
    
    func sendCurrentPlayerToServer(completion: @escaping (Bool) -> Void) {
        self.gameRepository.sendCurrentPlayerToServer(playerName: self.currentPlayPlayer.name, completion: { response in
            if response == self.currentPlayPlayer.name {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    
    
    
}

//
//  GameRepository.swift
//  NimbleSample
//
//  Created by hanwe on 2022/03/13.
//

protocol GameRepository {
    func sendCurrentPlayerToServer(playerName: String, completion: @escaping (String) -> Void)
}

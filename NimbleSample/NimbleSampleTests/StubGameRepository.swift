//
//  StubGameRepository.swift
//  NimbleSampleTests
//
//  Created by hanwe on 2022/03/13.
//

import UIKit
@testable import NimbleSample

class StubGameRepository: GameRepository {
    func sendCurrentPlayerToServer(playerName: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            usleep( 1000 * 1000)
            DispatchQueue.main.async {
                completion("John")
            }
        }
    }
}

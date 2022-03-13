//
//  QuickNimbleAsync.swift
//  NimbleSampleTests
//
//  Created by hanwe on 2022/03/13.
//

import Quick
import Nimble
@testable import NimbleSample

class AsyncSpec: QuickSpec {
    
    override func spec() {
        describe("사용자가 게임을 하고 있다") { // Given
            let player1: Player = Player(name: "John")
            let player2: Player = Player(name: "Tom")
            let game: Game = Game(firstPlayPlayer: player1, secondPlayPlayer: player2, gameRepository: StubGameRepository())
            context("현재 사용자를 서버로 보낸다.") { // When
                var isSame: Bool = false
                game.sendCurrentPlayerToServer(completion: { [weak self] result in
                    isSame = result
                })
                it("현재 사용자가 정상적으로 등록됐다??") { // Then
                    expect(isSame).toEventually(beTrue())
                }
            }
        }
    }
}

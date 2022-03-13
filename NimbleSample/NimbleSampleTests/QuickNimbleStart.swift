//
//  QuickNimbleStart.swift
//  NimbleSampleTests
//
//  Created by hanwe on 2022/03/13.
//

import Quick
import Nimble
@testable import NimbleSample

class StartSpec: QuickSpec {
    override func spec() {
        describe("사용자가 게임을 하고 있다") { // Given
            let player1: Player = Player(name: "John")
            let player2: Player = Player(name: "Tom")
            let game: Game = Game(firstPlayPlayer: player1, secondPlayPlayer: player2, gameRepository: StubGameRepository())
            context("한번 이동한다") { // When
                game.moveCurrentTurnPlayer()
                it("플레이어가 전환되어야 한다") { // Then
                    expect(game.currentPlayPlayer).to(equal(player2))
                }
            }
        }
    }
}

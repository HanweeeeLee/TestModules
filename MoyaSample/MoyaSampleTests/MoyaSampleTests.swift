//
//  MoyaSampleTests.swift
//  MoyaSampleTests
//
//  Created by hanwe lee on 2021/03/18.
//

import XCTest
@testable import MoyaSample
@testable import Moya
@testable import RxSwift


class MoyaSampleTests: XCTestCase {

    var sut: GithubUserProvider!
    override func setUpWithError() throws {
        sut = GithubUserProvider(isStub: true)
    }

    override func tearDownWithError() throws {
    }
    
    func test_MyFunc() {
        sut.provider.rx.request(.searchUser(query: "any"))
            .subscribe{ [weak self] resultValue in
                switch resultValue {
                case .success(let response):
                    print("response:\(response)")
                    break
                case .error(let err):
                    print("err:\(err.localizedDescription)")
                }
            }
            .dispose()
    }
    

}

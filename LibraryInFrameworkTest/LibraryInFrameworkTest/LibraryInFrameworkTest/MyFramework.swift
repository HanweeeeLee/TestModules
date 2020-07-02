//
//  MyFramework.swift
//  LibraryInFrameworkTest
//
//  Created by hanwe lee on 2020/07/02.
//  Copyright © 2020 hanwe. All rights reserved.
//

import OpenSSL

public class MyFramework {
    public func test() {
        print("hello world")
    }
    public init() {
        
    }
    public func genSafePrimeNumber(bits:Int) -> Int { //test
        var n = BN_new()
        if BN_generate_prime_ex(n, Int32(bits), 1, nil, nil, nil) != 1 {
            return 0
        }
        print("test:\(String(describing: n))")
        return 1
    }
}

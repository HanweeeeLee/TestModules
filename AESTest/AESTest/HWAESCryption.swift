//
//  HWAESCryption.swift
//  AESTest
//
//  Created by hanwe on 2020/07/11.
//  Copyright © 2020 hanwe. All rights reserved.
//

import Foundation
import CommonCrypto

enum HW_AES_Type {
    case aes128
    case aes256
}

class HWAESCryption {
    
    static func aesEncrypt(originalData:Data,iv:Data,key:Data,aesType:HW_AES_Type) -> Data {
        switch aesType {
        case .aes128:
            return aesCrypt(data: originalData,
                            iv: iv,
                            key: key,
                            context: CCOperation(kCCEncrypt),
                            aesSize: size_t(kCCKeySizeAES128)) ?? Data()
        case .aes256:
            return aesCrypt(data: originalData,
                            iv: iv,
                            key: key,
                            context: CCOperation(kCCEncrypt),
                            aesSize: size_t(kCCKeySizeAES256)) ?? Data()
        }
    }
    
    static func aesDecrypt(encData:Data,iv:Data,key:Data,aesType:HW_AES_Type) -> Data? {
        switch aesType {
        case .aes128:
            return aesCrypt(data: encData,
                            iv: iv,
                            key: key,
                            context: CCOperation(kCCDecrypt),
                            aesSize: size_t(kCCKeySizeAES128))
        case .aes256:
            return aesCrypt(data: encData,
                            iv: iv,
                            key: key,
                            context: CCOperation(kCCDecrypt),
                            aesSize: size_t(kCCKeySizeAES256))
        }
    }
    
    static private func aesCrypt(data:Data,iv:Data,key:Data,context:CCOperation,aesSize:size_t) -> Data? { //todo deprecated된 함수들 교체 //테스트하기
        //        CCCryptorStatus ccStatus = kCCSuccess;
        var numBytesEncrypted :size_t = 0 // Number of bytes moved to buffer.
        let cryptLength  = size_t(data.count + kCCBlockSizeAES128) // 이거는 aes 128이든 256이든 고정인가??
        var cryptData = Data(count:cryptLength)
        //        NSMutableData *dataOut = [NSMutableData dataWithLength:dataIn.length + kCCBlockSizeAES128];
        
        let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
            data.withUnsafeBytes {dataBytes in
                iv.withUnsafeBytes {ivBytes in
                    key.withUnsafeBytes {keyBytes in
                        CCCrypt(CCOperation(context),
                                CCAlgorithm(kCCAlgorithmAES),
                                CCOptions(kCCOptionPKCS7Padding),
                                keyBytes, aesSize,
                                ivBytes,
                                dataBytes, data.count,
                                cryptBytes, cryptLength,
                                &numBytesEncrypted)
                    }
                }
            }
        }
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.removeSubrange(numBytesEncrypted..<cryptData.count)
        } else {
            return nil
        }
        return cryptData
    }
}


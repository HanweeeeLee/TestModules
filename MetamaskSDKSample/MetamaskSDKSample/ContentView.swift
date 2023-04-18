//
//  ContentView.swift
//  MetamaskSDKSample
//
//  Created by Aaron Hanwe LEE on 2023/04/18.
//

import SwiftUI
import metamask_ios_sdk
import Combine

struct ContentView: View {
  
  @ObservedObject var ethereum = MetaMaskSDK.shared.ethereum
  @State private var cancellables: Set<AnyCancellable> = []
  @State var chainId: String?
  @State var balance: String?
  @State var message = "{\"domain\":{\"chainId\":1,\"name\":\"Ether Mail\",\"verifyingContract\":\"0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC\",\"version\":\"1\"},\"message\":{\"contents\":\"Hello, Linda!\",\"from\":{\"name\":\"Aliko\",\"wallets\":[\"0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826\",\"0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF\"]},\"to\":[{\"name\":\"Linda\",\"wallets\":[\"0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB\",\"0xB0BdaBea57B0BDABeA57b0bdABEA57b0BDabEa57\",\"0xB0B0b0b0b0b0B000000000000000000000000000\"]}]},\"primaryType\":\"Mail\",\"types\":{\"EIP712Domain\":[{\"name\":\"name\",\"type\":\"string\"},{\"name\":\"version\",\"type\":\"string\"},{\"name\":\"chainId\",\"type\":\"uint256\"},{\"name\":\"verifyingContract\",\"type\":\"address\"}],\"Group\":[{\"name\":\"name\",\"type\":\"string\"},{\"name\":\"members\",\"type\":\"Person[]\"}],\"Mail\":[{\"name\":\"from\",\"type\":\"Person\"},{\"name\":\"to\",\"type\":\"Person[]\"},{\"name\":\"contents\",\"type\":\"string\"}],\"Person\":[{\"name\":\"name\",\"type\":\"string\"},{\"name\":\"wallets\",\"type\":\"address[]\"}]}}"
  
  let chainIdRequest = EthereumRequest(method: .ethChainId)
  
  var body: some View {
    VStack {
      Button(action: {
        
        //        ethereum.request(chainIdRequest)?.sink(receiveCompletion: { completion in
        //            switch completion {
        //            case .failure(let error):
        //                print("\(error.localizedDescription)")
        //            default: break
        //            }
        //        }, receiveValue: { result in
        //            self.chainId = result as! String
        //        })
        //        .store(in: &cancellables)
        let dapp = Dapp(name: "Dub Dapp", url: "https://dubdapp.com")
        
        // This is the same as calling "eth_requestAccounts"
        ethereum.connect(dapp)
        
      }, label: {
        Text("메타마스크 연결")
      })
      
      Button(action: {
        ethereum.request(chainIdRequest)?.sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            print("\(error.localizedDescription)")
          default: break
          }
        }, receiveValue: { result in
          print("result:\(result)")
          self.chainId = result as! String
        })
        .store(in: &cancellables)
        
      }, label: {
        Text("체인아이디 얻기")
      })
      
      Button(action: {
        
        // Create parameters
        let parameters: [String] = [
          ethereum.selectedAddress, // address to check for balance
          "latest" // "latest", "earliest" or "pending" (optional)
        ]
        
        // Create request
        let getBalanceRequest = EthereumRequest(
          method: .ethGetBalance,
          params: parameters)
        
        // Make request
        ethereum.request(getBalanceRequest)?.sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            print("\(error.localizedDescription)")
          default: break
          }
        }, receiveValue: { result in
          print("잔고: \(result)")
          self.balance = result as! String
        })
        .store(in: &cancellables)
        
      }, label: {
        Text("잔고조회")
      })
      
      Button(action: {
        
        let from = ethereum.selectedAddress
        let params: [String] = [from, message]
        let signRequest = EthereumRequest(
          method: .ethSignTypedDataV4,
          params: params
        )
        
        ethereum.request(signRequest)?.sink(receiveCompletion: { completion in
          switch completion {
          case let .failure(error):
            print("err: \(error)")
          default: break
          }
        }, receiveValue: { value in
          print("signed value: \(value)")
        }).store(in: &cancellables)
        
      }, label: {
        Text("서명 data v4")
      })
    }
    .padding()
    
    Button(action: {
      
      let from = ethereum.selectedAddress
      let testMessage = "hello world"
      let params: [String] = [from, testMessage]
      let signRequest = EthereumRequest(
        method: .personalSign,
        params: params
      )
      
      ethereum.request(signRequest)?.sink(receiveCompletion: { completion in
        switch completion {
        case let .failure(error):
          print("err: \(error)")
        default: break
        }
      }, receiveValue: { value in
        print("signed value22: \(value)")
      }).store(in: &cancellables)
      
    }, label: {
      Text("서명 personal")
    })
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

//
//  GithubUserProvider.swift
//  MoyaSample
//
//  Created by hanwe lee on 2021/03/18.
//
import Moya

class GithubUserProvider: ProviderPtotocol {
    typealias T = GithubAPI
    var provider: MoyaProvider<GithubAPI>
    
    required init(isStub: Bool, sampleStatusCode: Int = 200, customEndpointClosure: ((GithubAPI) -> Endpoint)? = nil) {
        provider = Self.consProvider(isStub, sampleStatusCode, customEndpointClosure)
    }
}

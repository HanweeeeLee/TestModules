//
//  GithubAPI.swift
//  MoyaSample
//
//  Created by hanwe lee on 2021/03/18.
//

import Moya

enum GithubAPI {
    case searchUser(query: String)
}

extension GithubAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")! //서버의 도메인
    }
    
    var path: String {
        switch self {
        case .searchUser:
            return "search/users" // 서버의 도메인 뒤에 추가 될 Path (일반적으로 API)
        }
    }
    
    var method: Method {
        return .get //method
    }
    
    var sampleData: Data {
        return Data() // 테스트용 Mock Data
    }
    
    var task: Task { // 리퀘스트에 사용되는 파라미터 설정
        switch self {
        case .searchUser(let query):
            return .requestParameters(parameters: ["q" : query], encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType { //허용할 response의 타입
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? { //http header
        return nil
    }
    
}

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
        switch self {
        case .searchUser:
            return Data(
                """
                {
                "items" : [
                    {
                      "avatar_url" : "https://avatars.githubusercontent.com/u/60125719?v=4",
                      "subscriptions_url" : "https://api.github.com/users/HanweeeeLee/subscriptions",
                      "url" : "https://api.github.com/users/HanweeeeLee",
                      "id" : 60125719,
                      "starred_url" : "https://api.github.com/users/HanweeeeLee/starred{/owner}{/repo}",
                      "site_admin" : false,
                      "repos_url" : "https://api.github.com/users/HanweeeeLee/repos",
                      "login" : "HanweeeeLee",
                      "node_id" : "MDQ6VXNlcjYwMTI1NzE5",
                      "organizations_url" : "https://api.github.com/users/HanweeeeLee/orgs",
                      "received_events_url" : "https://api.github.com/users/HanweeeeLee/received_events",
                      "type" : "User",
                      "html_url" : "https://github.com/HanweeeeLee",
                      "following_url" : "https://api.github.com/users/HanweeeeLee/following{/other_user}",
                      "events_url" : "https://api.github.com/users/HanweeeeLee/events{/privacy}",
                      "followers_url" : "https://api.github.com/users/HanweeeeLee/followers",
                      "gravatar_id" : "",
                      "gists_url" : "https://api.github.com/users/HanweeeeLee/gists{/gist_id}",
                      "score" : 1
                    }
                  ],
                  "total_count" : 1,
                  "incomplete_results" : false
                }
                """.utf8
            )
        }
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



//
//  GithubUserData.swift
//  MoyaSample
//
//  Created by hanwe lee on 2021/03/18.
//

import Foundation
import FlexibleModelProtocol

struct GithubUserData: FlexibleModelProtocol {
    var name: String = ""
    var imgUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case imgUrl = "avatar_url"
    }
}

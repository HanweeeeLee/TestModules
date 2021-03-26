//
//  StoryBoarded.swift
//  CoordinatorSample
//
//  Created by hanwe on 2021/03/26.
//

import UIKit

protocol Storyboarded {
    static func instantiate(storyboardName: String) -> Self
    
}
extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

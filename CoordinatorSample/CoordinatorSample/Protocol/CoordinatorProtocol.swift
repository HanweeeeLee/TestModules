//
//  CoordinatorProtocol.swift
//  CoordinatorSample
//
//  Created by hanwe on 2021/03/26.
//

import UIKit

protocol CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navi: UINavigationController { get set }
    
    func start()
}

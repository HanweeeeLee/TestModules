//
//  CoordinatorProtocol.swift
//  CoordinatorSample2
//
//  Created by hanwe on 2021/03/27.
//

import UIKit

protocol Coordinator : class {
    var childCoordinators : [Coordinator] { get set }
    func start()
}

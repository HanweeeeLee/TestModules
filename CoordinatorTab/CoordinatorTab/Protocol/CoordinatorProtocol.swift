//
//  CoordinatorProtocol.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

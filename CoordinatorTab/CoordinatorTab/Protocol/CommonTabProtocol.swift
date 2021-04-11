//
//  TabViewProtocol.swift
//  CoordinatorTab
//
//  Created by hanwe on 2021/04/11.
//

import UIKit

enum TabType {
    case home
    case Category
}

protocol CommonTabProtocol: class {
    func moveTab(to: TabType)
}

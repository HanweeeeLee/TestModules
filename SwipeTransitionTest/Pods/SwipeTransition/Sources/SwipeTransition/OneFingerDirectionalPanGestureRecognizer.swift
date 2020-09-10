//
//  OneFingerDirectionalPanGestureRecognizer.swift
//  SwipeTransition
//
//  Created by Tatsuya Tanaka on 20180124.
//  Copyright © 2018年 tattn. All rights reserved.
//

import UIKit

final class OneFingerDirectionalPanGestureRecognizer: UIPanGestureRecognizer {
    enum PanDirection {
        case up //swiftlint:disable:this identifier_name
        case down
        case left
        case right
    }

    let direction: PanDirection

    required init(direction: PanDirection, target: Any? = nil, action: Selector? = nil) {
        self.direction = direction
        super.init(target: target, action: action)
        maximumNumberOfTouches = 1
        cancelsTouchesInView = false
        delaysTouchesBegan = true
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)

        if state == .began {
            let vel = velocity(in: view)
            switch direction {
            case .up where abs(vel.x) > abs(vel.y) || vel.y >= 0:
                state = .cancelled
            case .down where abs(vel.x) > abs(vel.y) || vel.y <= 0:
                state = .cancelled
            case .left where abs(vel.y) > abs(vel.x) || vel.x >= 0:
                state = .cancelled
            case .right where abs(vel.y) > abs(vel.x) || vel.x <= 0:
                state = .cancelled
            default:
                break
            }
        }
    }
}

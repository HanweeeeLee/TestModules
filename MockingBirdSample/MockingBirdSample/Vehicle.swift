//
//  Vehicle.swift
//  MockingBirdSample
//
//  Created by hanwe on 2022/03/06.
//

import Foundation

protocol Vehicle {
    
    var canDive: Bool { get }
    func dive()
    
    func canRide(_ object: DriverLicense) -> Bool
    func drive()
}

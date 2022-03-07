//
//  Human.swift
//  MockingBirdSample
//
//  Created by hanwe on 2022/03/07.
//

import UIKit

class Human: NSObject {
    func ride(_ vehicle: Vehicle, license: DriverLicense) {
        guard vehicle.canRide(license) else { return }
        vehicle.drive()
    }
    
    func dive(_ vehicle: Vehicle) {
        guard vehicle.canDive else { return }
        vehicle.dive()
    }
}

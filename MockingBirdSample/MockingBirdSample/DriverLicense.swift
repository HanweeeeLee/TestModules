//
//  Rider.swift
//  MockingBirdSample
//
//  Created by hanwe on 2022/03/06.
//

import UIKit

protocol DriverLicense {
  var age: Int { get }
}

struct LicenseForAdult: DriverLicense {
  let age = 20
}

struct LicenseForKid: DriverLicense {
  let age = 9
}

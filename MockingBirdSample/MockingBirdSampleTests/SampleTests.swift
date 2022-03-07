//
//  SampleTests.swift
//  MockingBirdSampleTests
//
//  Created by hanwe on 2022/03/06.
//

import XCTest
import Mockingbird
@testable import MockingBirdSample

class SampleTests: XCTestCase {
    
    
    var vehicle: VehicleMock!

    override func setUp() {
        vehicle = mock(Vehicle.self)
    }
    
    
    func testLicense1() {
        given(vehicle.canRide(any(where: { $0.age >= 20 }))).willReturn(true) // Given 20살 이상만 운전할 수 있음
        vehicle.useDefaultValues(from: .standardProvider) // (return `false` by default)
        Human().ride(vehicle, license: LicenseForKid()) // When 라이센스가 애들용이면
        verify(vehicle.drive()).wasNeverCalled() // Then 9살이기때문에 운전 할 수 없다.
    }
    
    func testLicense2() {
        given(vehicle.canRide(any(where: { $0.age >= 20 }))).willReturn(true) // Given 20살 이상만 운전할 수 있음
        vehicle.useDefaultValues(from: .standardProvider) // (return `false` by default)
        Human().ride(vehicle, license: LicenseForAdult()) // When 라이센스가 어른용이면
        verify(vehicle.drive()).wasCalled() // Then 성인이라 운전할 수 있다. (호출되었다.)
    }
    
    func testDive1() {
        given(vehicle.canDive).willReturn(true) // Given 탈것이 잠수할 수 있으면
        Human().dive(vehicle) // When 잠수했을 때
        verify(vehicle.dive()).wasCalled() // Then 잠수 할 수 있다
    }
    
    func testDive2() {
        given(vehicle.canDive).willReturn(false) // 탈것이 잠수할 수 없으면
        Human().dive(vehicle) // 잠수 했을 때
        verify(vehicle.dive()).wasNeverCalled() // 잠수 할 수 없었다.
    }

}

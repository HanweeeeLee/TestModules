//
//  ViewController.swift
//  CommandPetternTest
//
//  Created by hanwe lee on 2020/06/08.
//  Copyright © 2020 hanwe lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let on = PullSwitchLightOnCommand()
        let off = PullSwitchLightOffCommand()
        let light = Light(lightOnCommand: on, lightOffCommand: off)
        
        light.turnOnLight()
        light.turnOffLight()
        
        light.lightOnCommand = RocketSwitchLightOnCommand()
        light.turnOnLight()
    }


}

protocol Command {
    func execute()
}

struct RocketSwitchLightOnCommand:Command {
    func execute() {
        print("Rocker Switch: Turning Light On")
    }
}

struct RocketSwitchLightOffCommand:Command {
    func execute() {
        print("Rocker Switch: Turning Light Off")
    }
}

struct PullSwitchLightOnCommand:Command {
    func execute() {
        print("Pull Switch: Turning Light On")
    }
}

struct PullSwitchLightOffCommand:Command {
    func execute() {
        print("Pull Switch: Turning Light Off")
    }
}

//커맨드 호출자
class Light {
    var lightOnCommand:Command
    var lightOffCommand:Command
    
    init(lightOnCommand:Command,lightOffCommand:Command) {
        self.lightOnCommand = lightOnCommand
        self.lightOffCommand = lightOffCommand
    }
    
    func turnOnLight() {
        self.lightOnCommand.execute()
    }
    
    func turnOffLight() {
        self.lightOffCommand.execute()
    }
}



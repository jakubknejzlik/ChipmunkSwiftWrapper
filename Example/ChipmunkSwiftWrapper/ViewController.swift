//
//  ViewController.swift
//  ChipmunkSwiftWrapper
//
//  Created by jakubknejzlik on 11/17/2015.
//  Copyright (c) 2015 jakubknejzlik. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as? SKView {
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .AspectFit
            
            view.showsFPS = true
            
            view.presentScene(scene)
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


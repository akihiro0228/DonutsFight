//
//  GameViewController.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    @IBOutlet weak var gameView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = self.gameView as SKView

        // Debug
        skView.showsDrawCount = true
        skView.showsNodeCount = true
        skView.showsFPS       = true

        // マルチタップ禁止
        skView.multipleTouchEnabled = false

        convert.sceneSize = self.gameView.bounds.size
        let scene = GameScene(size: convert.sceneSize)
        skView.presentScene(scene)
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

//
//  GameScene.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class GameScene: BaseScene {
    let world       : World
    let overlay     : Overlay
    let camera      : Camera
    let eatSeat     : SpriteNode
    let stomachSeat : SpriteNode
    let donutsMan   : DonutsMan

    var eatDunutsDuration : CGFloat
    var isLastUpdateTimeInitialized : Bool
    var lastUpdateTime : CFTimeInterval
    var gameTime : Double
    var gameCount : Int
    var createEatDonutsTime : Double

    override init(size: CGSize) {
        self.world       = World()
        self.overlay     = Overlay()
        self.camera      = Camera()
        self.eatSeat     = SpriteNode()
        self.stomachSeat = SpriteNode()
        self.donutsMan   = DonutsMan()
        self.eatDunutsDuration = 5
        self.isLastUpdateTimeInitialized = false
        self.lastUpdateTime = 0
        self.gameTime = 0
        self.gameCount   = 0
        self.createEatDonutsTime = 0
        super.init(size: size)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        self.addChild(self.world)
        self.world.addChild(self.camera)
        self.addChild(self.overlay)

        // XXX: 仮
        self.eatSeat.size = CGSize(width: 320, height: 142)
        self.eatSeat.position = CGPoint(x: 0, y: 213)
        self.eatSeat.color = UIColor.whiteColor()
        self.eatSeat.zPosition = 100
        self.world.addChild(self.eatSeat)

        // XXX: 仮
        self.stomachSeat.size = CGSize(width: 320, height: 426)
        self.stomachSeat.position = CGPoint(x: 0, y: -71)
        self.stomachSeat.color = UIColor.whiteColor()
        self.world.addChild(self.stomachSeat)

        // DonutsMan
        self.eatSeat.addChild(self.donutsMan)

        // 壁
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)

        // 重力を発生させる
        self.setGravity(CGVectorMake(0, -2.0))
    }

    override func didMoveToView(view: SKView) {

    }

    // TODO: もっと綺麗に書けるはずだけど、GameJam中なのでゴメンナサイ
    override func didSimulatePhysics() {
        let point = self.camera.position
        self.camera.position = CGPoint(x: point.x - 160, y: point.y - 284)
        self.centerOnNode(self.camera)
        self.camera.position = point
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)

            self.createStomachDonuts() // TODO: ドーナツが食べられてたタイミングでcreateするようにする
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        // FPSに依存しない実時間を測る
        if !self.isLastUpdateTimeInitialized {
            self.isLastUpdateTimeInitialized = true
            self.lastUpdateTime = currentTime;
        }

        let timeSinceLast = currentTime - self.lastUpdateTime
        self.lastUpdateTime = currentTime

        self.gameTime += timeSinceLast


        // 一定間隔でドーナツを生成する
        let donutsInterval = Int(self.eatDunutsDuration / 5)
        if  Int(self.gameTime) != Int(self.createEatDonutsTime) && Int(self.gameTime) % donutsInterval == 0{
            self.createEatDonuts()
            self.createEatDonutsTime = self.gameTime
        }

        self.gameCount++
    }

    func createEatDonuts() {
        let eatDonuts = EatDonuts()
        self.eatSeat.addChild(eatDonuts)
        eatDonuts.startAnimation(self.eatDunutsDuration)
    }

    func createStomachDonuts() {
        let stomachDonuts = StomachDonuts()
        stomachDonuts.onPhysics()
        self.stomachSeat.addChild(stomachDonuts)
    }
}

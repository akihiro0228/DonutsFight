//
//  GameScene.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

enum Category {
    case StomachDonuts
    case RemoveDonuts
    case Wall

    func bit() -> UInt32 {
        switch self{
        case Category.StomachDonuts:
            return 0x1 << 0
        case Category.RemoveDonuts:
            return 0x1 << 1
        case Category.Wall:
            return 0x1 << 0
        }
    }
}

import SpriteKit

class GameScene: BaseScene, SKPhysicsContactDelegate {
    let world       : World
    let overlay     : Overlay
    let camera      : Camera
    let eatSeat     : SpriteNode
    let stomachSeat : SpriteNode
    let donutsMan   : DonutsMan
    let scoreSeat   : SpriteNode
    let score       : Score

    var eatDunutsDuration : CGFloat
    var isLastUpdateTimeInitialized : Bool
    var lastUpdateTime : CFTimeInterval
    var gameTime : Double
    var gameCount : Int
    var createEatDonutsTime : Double
    var chainCount : Int
    var removeCount : Int {
        didSet {
            if removeCount > 0 {
                self.eatSeat.paused = true
            }
            else {
                self.eatSeat.paused = false
                self.isLastUpdateTimeInitialized = false
                self.chainCount = 0
            }
        }
    }

    override init(size: CGSize) {
        self.world       = World()
        self.overlay     = Overlay()
        self.camera      = Camera()
        self.eatSeat     = SpriteNode()
        self.stomachSeat = SpriteNode()
        self.donutsMan   = DonutsMan()
        self.scoreSeat   = SpriteNode()
        self.score       = Score()
        self.eatDunutsDuration = 5
        self.isLastUpdateTimeInitialized = false
        self.lastUpdateTime = 0
        self.gameTime = 0
        self.gameCount   = 0
        self.createEatDonutsTime = 0
        self.chainCount = 0
        self.removeCount = 0
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

        // 食事シート
        self.eatSeat.size = CGSize(width: 320, height: 142)
        self.eatSeat.position = CGPoint(x: 0, y: 213)
        self.eatSeat.texture = SKTexture(imageNamed: "eat_background")
        self.eatSeat.zPosition = 100
        self.world.addChild(self.eatSeat)

        // スコアシート
        self.scoreSeat.size = CGSize(width: 320, height: 142)
        self.scoreSeat.texture = SKTexture(imageNamed: "score_background")
        self.eatSeat.addChild(self.scoreSeat)

        // スコア
        /*
        let scoreLabel = LabelNode()
        scoreLabel.text = "すこあ"
        scoreLabel.position = CGPoint(x: 45, y: 40)
        scoreLabel.fontSize = 16
        scoreLabel.fontName = "かんじゅくゴシック"
        scoreLabel.fontColor = UIColor.whiteColor()
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        scoreLabel.verticalAlignmentMode   = SKLabelVerticalAlignmentMode.Center
        self.scoreSeat.addChild(scoreLabel)
        */

        self.score.position = CGPoint(x: 80, y: 40)
        self.score.fontSize = 20
        self.score.fontName = "かんじゅくゴシック"
        self.score.fontColor = UIColor.whiteColor()
        self.score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        self.score.verticalAlignmentMode   = SKLabelVerticalAlignmentMode.Center
        self.scoreSeat.addChild(self.score)

        // ギャラリーシート
        let gallery = SpriteNode()
        gallery.size = CGSize(width: 320, height: 142)
        gallery.texture = SKTexture(imageNamed: "gallery")
        gallery.zPosition = 100
        self.eatSeat.addChild(gallery)

        // 胃シート
        self.stomachSeat.size = CGSize(width: 320, height: 426)
        self.stomachSeat.position = CGPoint(x: 0, y: -71)
        self.stomachSeat.texture = SKTexture(imageNamed: "stomach_background")
        self.world.addChild(self.stomachSeat)

        // DonutsMan
        self.eatSeat.addChild(self.donutsMan)

        // 壁
        let wallRect = CGRect(x: 15, y: 15, width: 290, height: 538)
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: convert.oRect(wallRect))
        self.physicsBody?.categoryBitMask = Category.Wall.bit()
        self.physicsBody?.collisionBitMask = Category.StomachDonuts.bit()

        // 重力を発生させる
        self.setGravity(CGVectorMake(0, -2.0))

        self.physicsWorld.contactDelegate = self

        self.paused = true
    }

    override func didMoveToView(view: SKView) {
        self.paused = false
    }

    // TODO: もっと綺麗に書けるはずだけど、GameJam中なのでゴメンナサイ
    override func didSimulatePhysics() {
        let point = self.camera.position
        self.camera.position = CGPoint(x: point.x - 160, y: point.y - 284)
        self.centerOnNode(self.camera)
        self.camera.position = point
    }

    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody, secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.categoryBitMask & Category.RemoveDonuts.bit() != 0 &&
            secondBody.categoryBitMask & Category.StomachDonuts.bit() != 0 {
                let removeDonuts  = firstBody.node  as? StomachDonuts
                let stomachDonuts = secondBody.node as? StomachDonuts

                if removeDonuts != nil && stomachDonuts != nil {
                    if removeDonuts!.type == stomachDonuts!.type {
                        stomachDonuts?.remove()
                    }
                }
        }
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)

            let target = self.nodeAtPoint(location) as? StomachDonuts
            if self.removeCount == 0 && target?.name == "stomachDonuts" {
                target?.startRemoveAnimation()
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if !self.paused && !self.eatSeat.paused {
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
    }

    func createEatDonuts() {
        let eatDonuts = EatDonuts()
        self.eatSeat.addChild(eatDonuts)
        eatDonuts.startAnimation(self.eatDunutsDuration)
    }

    func createStomachDonuts(eatDonuts: EatDonuts) {
        let stomachDonuts = StomachDonuts(eatDonuts: eatDonuts)
        stomachDonuts.onPhysics()
        stomachDonuts.physicsBody?.categoryBitMask    = Category.StomachDonuts.bit()
        stomachDonuts.physicsBody?.collisionBitMask   = Category.StomachDonuts.bit()
        stomachDonuts.physicsBody?.contactTestBitMask = Category.RemoveDonuts.bit()
        self.stomachSeat.addChild(stomachDonuts)
    }
}

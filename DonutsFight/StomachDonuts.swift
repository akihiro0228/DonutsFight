//
//  StomachDonuts.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class StomachDonuts: Donuts {

    init(eatDonuts: EatDonuts) {
        super.init()
        self.size = self.sizeType.size()
        self.type = eatDonuts.type
        self.texture = SKTexture(imageNamed: self.type.imageName())
        self.name = "stomachDonuts"
        setRandomPosition(Min: -100, Max: 100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startRemoveAnimation() {
        let path = CGPathCreateMutable()

        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddArc(path, nil, 0, 0, self.size.width/2, 0, 0, false)

        CGPathCloseSubpath(path)
        let arc = SKShapeNode(path: path)
        arc.fillColor = UIColor.blackColor()
        arc.strokeColor = UIColor.clearColor()
        arc.alpha = 0.5
        self.addChild(arc)

        let removeTime = self.sizeType.removeTime()

        let action = SKAction.customActionWithDuration(removeTime, actionBlock: {(node, time) in
            let rad = CGFloat(2.0 * M_PI) * CGFloat(time) / CGFloat(removeTime)
            let path = CGPathCreateMutable()

            CGPathMoveToPoint(path, nil, 0, 0)
            CGPathAddArc(path, nil, 0, 0, self.size.width/2, 0, rad, false)

            CGPathCloseSubpath(path)
            arc.path = path
        })

        arc.runAction(action, completion: {
            arc.removeFromParent()
            self.remove()
        })
    }

    func remove() {
        let scene = self.parent!.parent!.parent as! GameScene
        scene.removeCount++
        scene.chainCount++

        self.alpha = 0.3
        self.size = CGSize(width: self.size.width * 1.2, height: self.size.height * 1.2)

        self.physicsBody = SKPhysicsBody(circleOfRadius: convert.o(self.size.width*1.2/2))
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask    = Category.RemoveDonuts.bit()
        self.physicsBody?.contactTestBitMask = Category.StomachDonuts.bit()

        // チェインが多く、サイズが大きいほどスコアが高い
        let score = scene.chainCount * Int(self.size.width / 10)
        scene.score.addScore(score)

        self.runAction(SKAction.waitForDuration(1.3), completion: {
            self.removeFromParent()
            scene.removeCount--
        })
    }
}

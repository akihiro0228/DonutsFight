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
        self.size = CGSize(width: eatDonuts.size.width + 30, height: eatDonuts.size.height + 30)
        self.type = eatDonuts.type
        self.texture = SKTexture(imageNamed: self.type.imageName())
        self.name = "stomachDonuts"
        setRandomPosition(Min: -100, Max: 100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startRemoveAnimation() {
        self.alpha = 0.3
        self.size = CGSize(width: self.size.width * 1.2, height: self.size.height * 1.2)

        self.physicsBody = SKPhysicsBody(circleOfRadius: convert.o(self.size.width*1.2/2))
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask    = Category.RemoveDonuts.bit()
        self.physicsBody?.contactTestBitMask = Category.StomachDonuts.bit()

        self.runAction(SKAction.waitForDuration(2), completion: {
            let scene = self.parent!.parent!.parent as! GameScene
            self.removeFromParent()
            scene.isRemoveDonuts = false
        })
    }
}

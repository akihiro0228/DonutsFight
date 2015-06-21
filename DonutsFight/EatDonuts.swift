//
//  EatDonuts.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class EatDonuts: Donuts {

    override init() {
        super.init()
        let sizeWhenStomach = self.sizeType.size()
        self.size = CGSize(width: sizeWhenStomach.width - 30, height: sizeWhenStomach.height - 30)
        self.position = CGPoint(x: 200, y: 0)
        self.texture = SKTexture(imageNamed: self.type.imageName())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation(duration: CGFloat) {
        let action = SKAction.moveToX(-60, duration: NSTimeInterval(duration))
        self.runAction(action, completion: {
            let scene = self.parent!.parent!.parent as! GameScene
            scene.donutsMan.eatAnimation()
            self.fadeoutAnimation()
        })
    }

    func fadeoutAnimation() {
        let action_01 = SKAction.moveToX(-110, duration: 0.5)
        let action_02 = SKAction.fadeOutWithDuration(0.5)
        self.runAction(SKAction.group([action_01, action_02]), completion: {
            let scene = self.parent!.parent!.parent as! GameScene
            scene.createStomachDonuts(self)
            self.removeFromParent()
        })
    }
}

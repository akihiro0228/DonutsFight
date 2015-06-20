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
        setRandomSize(Min: 15, Max: 45)
        self.position = CGPoint(x: 200, y: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation(duration: CGFloat) {
        let action = SKAction.moveToX(-110, duration: NSTimeInterval(duration))
        self.runAction(action)
    }
}

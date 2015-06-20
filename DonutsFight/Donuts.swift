//
//  Donuts.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class Donuts: SpriteNode {

    func onPhysics() {
        physicsBody = SKPhysicsBody(circleOfRadius: convert.o(self.size.width/2))
    }

    func setRandomSize(Min _Min : CGFloat, Max _Max : CGFloat) {
        let random = self.random(Min: _Min, Max: _Max)
        self.size = CGSize(width: random, height: random)
    }

    func setRandomPosition(Min _Min : CGFloat, Max _Max : CGFloat) {
        let random = self.random(Min: _Min, Max: _Max)
        self.position = CGPoint(x: random, y: 250)
    }

    func random(Min _Min : CGFloat, Max _Max : CGFloat) -> CGFloat {
        return ( CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX) ) * (_Max - _Min) + _Min
    }
}

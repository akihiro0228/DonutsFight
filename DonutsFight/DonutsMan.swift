//
//  DonutsMan.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class DonutsMan: SpriteNode {

    override init() {
        super.init()
        self.texture = SKTexture(imageNamed: "donuts_man_03")
        self.size = CGSize(width: 80, height: 80)
        self.position = CGPoint(x: -110, y: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func eatAnimation() {
        // TODO:
        println("animation!!")
    }
}

//
//  DonutsMan.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class DonutsMan: SpriteNode {
    var images : [SKTexture]

    override init() {
        self.images = []
        super.init()
        let donutsMans = SKTexture(imageNamed: "donuts_man")
        for i in (0..<4) {
            let x = CGFloat(i) * 500 / donutsMans.size().width
            let width  = 500 / donutsMans.size().width
            let height = 500 / donutsMans.size().height

            self.images.append(SKTexture(rect: CGRect(x: x, y: 0, width: width, height: height), inTexture: donutsMans))
        }
        self.texture = images[2]
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

//
//  SpriteNode.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class SpriteNode: SKSpriteNode {

    override var size: CGSize {
        get {
            return convert.rSize(super.size)
        }
        set {
            super.size = convert.oSize(newValue)
        }
    }

    override var position: CGPoint {
        get {
            return convert.rPoint(super.position)
        }
        set {
            super.position = convert.oPoint(newValue)
        }
    }

    init() {
        super.init(texture: nil, color: UIColor.blackColor(), size: CGSizeZero)
        self.position = CGPointZero
        self.size     = CGSizeZero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
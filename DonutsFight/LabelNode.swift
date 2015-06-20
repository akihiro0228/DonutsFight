//
//  LabelNode.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class LabelNode: SKLabelNode {

    override var position: CGPoint {
        get {
            return convert.rPoint(super.position)
        }
        set {
            super.position = convert.oPoint(newValue)
        }
    }

    override var fontSize: CGFloat {
        get {
            return convert.r(super.fontSize)
        }
        set {
            super.fontSize = convert.o(newValue)
        }
    }

    override init() {
        super.init()
        self.position = CGPointZero
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
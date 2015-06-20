//
//  Camera.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class Camera: Node {

    override var position: CGPoint {
        get {
            /*
            let convertPoint = convert.rPoint(super.position)
            return CGPoint(x: convertPoint.x + 160, y: convertPoint.y + 284)
            */
            return convert.rPoint(super.position)
        }
        set {
            /*
            let newPoint = CGPoint(x: newValue.x - 160, y: newValue.y - 284)
            super.position = convert.oPoint(newPoint)
            */
            super.position = convert.oPoint(newValue)
        }
    }

    override init() {
        super.init()

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        
    }
}
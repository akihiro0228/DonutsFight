//
//  BaseScene.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene {

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
    }

    func setGravity(gravity: CGVector) {
        physicsWorld.gravity = gravity
    }
    
    func centerOnNode(node: SKNode) {
        let cameraPositionInScene: CGPoint = node.scene!.convertPoint(node.position, fromNode: node.parent!)

        node.parent!.position = CGPoint(x:node.parent!.position.x - cameraPositionInScene.x, y:node.parent!.position.y - cameraPositionInScene.y)
    }
}

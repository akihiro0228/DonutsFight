//
//  GameScene.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class GameScene: BaseScene {
    let world:   World
    let overlay: Overlay
    let camera:  Camera

    override init(size: CGSize) {
        self.world   = World()
        self.overlay = Overlay()
        self.camera  = Camera()
        super.init(size: size)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        self.addChild(self.world)
        self.world.addChild(self.camera)
        self.addChild(self.overlay)

        // XXX: 仮
        let eatSeat = SpriteNode()
        eatSeat.size = CGSize(width: 320, height: 142)
        eatSeat.position = CGPoint(x: 0, y: 213)
        eatSeat.color = UIColor.blueColor()
        self.world.addChild(eatSeat)

        // XXX: 仮
        let stomachSeat = SpriteNode()
        stomachSeat.size = CGSize(width: 320, height: 426)
        stomachSeat.position = CGPoint(x: 0, y: -71)
        stomachSeat.color = UIColor.brownColor()
        self.world.addChild(stomachSeat)
    }

    override func didMoveToView(view: SKView) {

    }

    // TODO: もっと綺麗に書けるはずだけど、GameJam中なのでゴメンナサイ
    override func didSimulatePhysics() {
        let point = self.camera.position
        self.camera.position = CGPoint(x: point.x - 160, y: point.y - 284)
        self.centerOnNode(self.camera)
        self.camera.position = point
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {

    }
   
    override func update(currentTime: CFTimeInterval) {

    }
}

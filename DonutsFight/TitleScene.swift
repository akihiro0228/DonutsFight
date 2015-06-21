//
//  TitleScene.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/21.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class TitleScene: BaseScene {
    let titleSeat : SpriteNode

    override init(size: CGSize) {
        self.titleSeat = SpriteNode()
        super.init(size: size)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.titleSeat.size = CGSize(width: 320, height: 568)
        self.titleSeat.position = CGPoint(x: 160, y: 284)
        self.titleSeat.texture = SKTexture(imageNamed: "title_background")
        self.addChild(self.titleSeat)
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let scene = GameScene(size: self.size)
        let transition = SKTransition.crossFadeWithDuration(1)
        self.view?.presentScene(scene, transition: transition)
    }
}
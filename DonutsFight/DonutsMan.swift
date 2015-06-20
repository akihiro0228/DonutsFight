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
        self.size = CGSize(width: 60, height: 60)
        self.position = CGPoint(x: -120, y: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  StomachDonuts.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class StomachDonuts: Donuts {

    init(eatDonuts: EatDonuts) {
        super.init()
        self.size = CGSize(width: eatDonuts.size.width + 30, height: eatDonuts.size.height + 30)
        self.texture = SKTexture(imageNamed: eatDonuts.type.imageName())
        self.name = "stomachDonuts"
        setRandomPosition(Min: -100, Max: 100)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

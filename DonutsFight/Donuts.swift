//
//  Donuts.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

enum DonutsType {
    case Type01
    case Type02
    case Type03
    case Type04
    case Type05

    func imageName () -> String {
        switch self{
        case DonutsType.Type01:
            return "donuts_01"
        case DonutsType.Type02:
            return "donuts_02"
        case DonutsType.Type03:
            return "donuts_03"
        case DonutsType.Type04:
            return "donuts_04"
        case DonutsType.Type05:
            return "donuts_05"
        default :
            return ""
        }
    }

    static func random() -> DonutsType {
        let rnd = arc4random() % 5

        switch rnd {
        case 0:  return .Type01
        case 1:  return .Type02
        case 2:  return .Type03
        case 3:  return .Type04
        case 4:  return .Type05
        default: return .Type01
        }
    }
}

import SpriteKit

class Donuts: SpriteNode {
    var type: DonutsType

    override init() {
        self.type = DonutsType.random()
        super.init()

        self.texture = SKTexture(imageNamed: self.type.imageName())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onPhysics() {
        physicsBody = SKPhysicsBody(circleOfRadius: convert.o(self.size.width/2))
    }

    func setRandomSize(Min _Min : CGFloat, Max _Max : CGFloat) {
        let random = self.random(Min: _Min, Max: _Max)
        self.size = CGSize(width: random, height: random)
    }

    func setRandomPosition(Min _Min : CGFloat, Max _Max : CGFloat) {
        let random = self.random(Min: _Min, Max: _Max)
        self.position = CGPoint(x: random, y: 250)
    }

    func random(Min _Min : CGFloat, Max _Max : CGFloat) -> CGFloat {
        return ( CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX) ) * (_Max - _Min) + _Min
    }
}

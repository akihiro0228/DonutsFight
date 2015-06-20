//
//  Convert.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/20.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import Foundation
import SpriteKit

class Convert {
    class var sharedInstance : Convert {
        struct Static {
            static let instance : Convert = Convert()
        }
        return Static.instance
    }

    var sceneSize: CGSize = CGSizeZero

    // order
    func o(n: CGFloat) -> CGFloat {
        return n * self.sceneSize.width / 320.0
    }

    func oSize(size: CGSize) -> CGSize {
        return CGSizeMake(o(size.width), o(size.height))
    }

    func oPoint(point: CGPoint) -> CGPoint {
        return CGPointMake(o(point.x), o(point.y))
    }

    func oRect(rect: CGRect) -> CGRect {
        return CGRectMake(o(rect.origin.x), o(rect.origin.y), o(rect.width), o(rect.height))
    }

    // reverse
    func r(n: CGFloat) -> CGFloat {
        return n * 320.0 / self.sceneSize.width
    }

    func rSize(size: CGSize) -> CGSize {
        return CGSizeMake(r(size.width), r(size.height))
    }

    func rPoint(point: CGPoint) -> CGPoint {
        return CGPointMake(r(point.x), r(point.y))
    }

    func rRect(rect: CGRect) -> CGRect {
        return CGRectMake(r(rect.origin.x), r(rect.origin.y), r(rect.width), r(rect.height))
    }
}

let convert = Convert.sharedInstance

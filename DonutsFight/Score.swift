//
//  Score.swift
//  DonutsFight
//
//  Created by akihiro on 2015/06/21.
//  Copyright (c) 2015年 akihiro. All rights reserved.
//

import SpriteKit

class Score: LabelNode {
    var _score : Int

    override init() {
        self._score = 0
        super.init()

        self.text = self._score.description
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addScore(score: Int) {
        self._score = self._score + score
        self.text = self._score.description
    }

    func setScore(score: Int) {
        self._score = score
        self.text = self._score.description
    }

    func getScore() -> Int {
        return self._score
    }
}
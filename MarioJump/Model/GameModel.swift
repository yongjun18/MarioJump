//
//  GameModel.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/21.
//

import Foundation

struct AnimationConst {
    struct Mario {
        public static let initY = -145.0
        public static let maxY = -270.0
        public static let upDuration = 0.20
        public static let downDuration = 0.17
    }
    struct Box {
        public static let initY = -350.0
        public static let maxY = -400.0
        public static let upDuration = 0.10
        public static let downDuration = 0.10
    }
    struct Coin {
        public static let initY = -350.0
        public static let maxY = -600.0
        public static let upDuration = 0.20
        public static let downDuration = 0.20
    }
    struct Mushroom {
        public static let initY = -350.0
        public static let initX = 0.0
        public static let maxY = -420.0
        public static let minY = -130.0
        public static let maxX = 1000.0
        public static let upDuration = 0.40
        public static let rightDuration = 0.20
        public static let downDuration = 0.40
        public static let lifeDuration = 5.00
    }
}

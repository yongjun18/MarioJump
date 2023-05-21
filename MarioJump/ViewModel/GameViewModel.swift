//
//  GameViewModel.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/21.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var coinCnt = 0
    @Published var animating = false
    @Published var marioAnimating = false
    @Published var marioY = AnimationConst.Mario.initY
    @Published var boxY = AnimationConst.Box.initY
    @Published var coinY = AnimationConst.Coin.initY
}

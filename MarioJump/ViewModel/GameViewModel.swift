//
//  GameViewModel.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/21.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var coinCnt = 0
    @Published var marioY = AnimationConst.Mario.initY
    @Published var boxY = AnimationConst.Box.initY
    @Published var coinY = AnimationConst.Coin.initY
    @Published var marioJumping = false
    var boxActive = true
    
    // 마리오 점프 시키기
    func marioJump() {
        // 마리오 점프 시작
        withAnimation(
            Animation.easeOut(duration: AnimationConst.Mario.upDuration)
                .delay(0)) {
                    marioY = AnimationConst.Mario.maxY
                }
        // 박스 히트
        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationConst.Mario.upDuration) {
            if self.boxActive {
                self.boxActive = false
                self.hitBox()
            }
        }
        // 마리오 하강 시작
        withAnimation(
            Animation.easeIn(duration: AnimationConst.Mario.downDuration)
                .delay(AnimationConst.Mario.upDuration)) {
                    marioY = AnimationConst.Mario.initY
                }
        // 마리오 착지
        DispatchQueue.main.asyncAfter(
            deadline: .now() + AnimationConst.Mario.upDuration + AnimationConst.Mario.downDuration) {
                self.marioJumping = false
            }
    }
    
    // 박스 히트
    func hitBox() {
        // 박스 점프 시작
        withAnimation(
            Animation.easeOut(duration: AnimationConst.Box.upDuration)
                .delay(0)) {
                    boxY = AnimationConst.Box.maxY
                }
        // 박스 하강 시작
        withAnimation(
            Animation.easeIn(duration: AnimationConst.Box.downDuration)
                .delay(AnimationConst.Box.upDuration)) {
                    boxY = AnimationConst.Box.initY
                }
        
        popCoin()
        DispatchQueue.main.asyncAfter(
            deadline: .now() + AnimationConst.Coin.upDuration + AnimationConst.Coin.downDuration) {
                self.boxActive = true
            }
    }
    
    // 코인 당첨
    func popCoin() {
        self.coinCnt += 1
        
        // 코인 점프 시작
        withAnimation(
            Animation.easeOut(duration: AnimationConst.Coin.upDuration)
                .delay(0)) {
                    coinY = AnimationConst.Coin.maxY
                }
        // 코인 하강 시작
        withAnimation(
            Animation.easeIn(duration: AnimationConst.Coin.downDuration)
                .delay(AnimationConst.Coin.upDuration)) {
                    coinY = AnimationConst.Coin.initY
                }
    }
}

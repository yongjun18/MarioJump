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
    @Published var animating = false
    @Published var marioAnimating = false
    @Published var marioY = AnimationConst.Mario.initY
    @Published var boxY = AnimationConst.Box.initY
    @Published var coinY = AnimationConst.Coin.initY
    
    // 애니메이션 실행
    func animate() {
        let hitBoxTime = 0.20
        let marioStopTime = 0.37
        
        let boxDropTime = 0.30
        let boxStopTime = boxDropTime + (boxDropTime - hitBoxTime)
        let coinDropTime = 0.40
        let coinStopTime = coinDropTime + (coinDropTime - hitBoxTime)
         
        // 마리오 점프 시작
        withAnimation(
            Animation.easeOut(duration: hitBoxTime)
                .delay(0)) {
                    marioY = AnimationConst.Mario.maxY
        }
        // 마리오 하강 시작
        withAnimation(
            Animation.easeIn(duration: marioStopTime - hitBoxTime)
                .delay(hitBoxTime)) {
                    marioY = AnimationConst.Mario.initY
        }
        // 마리오 착지
        DispatchQueue.main.asyncAfter(deadline: .now() + marioStopTime) {
            self.marioAnimating = false
        }
        
        // 박스 점프 시작
        withAnimation(
            Animation.easeOut(duration: boxDropTime - hitBoxTime)
                .delay(hitBoxTime)) {
                    boxY = AnimationConst.Box.maxY
        }
        // 박스 하강 시작
        withAnimation(
            Animation.easeIn(duration: boxStopTime - boxDropTime)
                .delay(boxDropTime)) {
                    boxY = AnimationConst.Box.initY
        }
        
        // 코인 카운트 증가
        DispatchQueue.main.asyncAfter(deadline: .now() + hitBoxTime) {
            self.coinCnt += 1
        }
        // 코인 점프 시작
        withAnimation(
            Animation.easeOut(duration: coinDropTime - hitBoxTime)
                .delay(hitBoxTime)) {
                    coinY = AnimationConst.Coin.maxY
        }
        // 코인 하강 시작
        withAnimation(
            Animation.easeIn(duration: coinStopTime - coinDropTime)
                .delay(coinDropTime)) {
                    coinY = AnimationConst.Coin.initY
        }
        
        // 최종 애니메이션 종료
        DispatchQueue.main.asyncAfter(deadline: .now() + coinStopTime) {
            self.animating = false
        }

    }
}

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
    @Published var mushroomY = AnimationConst.Mushroom.initY
    @Published var mushroomX = AnimationConst.Mushroom.initX
    @Published var marioJumping = false
    var boxActive = true
    var mushroomReady = true
    
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
        
        // 버섯이 대기 상태일 때, 10% 확률로 버섯 등장
        if mushroomReady && Int.random(in: 0..<10) == 0 {
            mushroomReady = false
            
            popMushroom()
            DispatchQueue.main.asyncAfter(
                deadline: .now() + AnimationConst.Mushroom.upDuration + AnimationConst.Mushroom.rightDuration) {
                    self.boxActive = true
                }
            DispatchQueue.main.asyncAfter(
                deadline: .now() + AnimationConst.Mushroom.lifeDuration) {
                    self.mushroomReady = true
                    self.mushroomX = AnimationConst.Mushroom.initX
                    self.mushroomY = AnimationConst.Mushroom.initY
                }
        }
        else {
            popCoin()
            DispatchQueue.main.asyncAfter(
                deadline: .now() + AnimationConst.Coin.upDuration + AnimationConst.Coin.downDuration) {
                    self.boxActive = true
                }
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
    
    // 버섯 당첨
    func popMushroom() {
        self.coinCnt += 10
        
        // 버섯 상승 시작
        withAnimation(
            Animation.linear(duration: AnimationConst.Mushroom.upDuration)
                .delay(0)) {
                    mushroomY = AnimationConst.Mushroom.maxY
                }
        // 버섯 아래 이동 시작
        withAnimation(
            Animation.easeIn(duration: AnimationConst.Mushroom.downDuration)
                .delay(AnimationConst.Mushroom.upDuration + AnimationConst.Mushroom.rightDuration)) {
                    mushroomY = AnimationConst.Mushroom.minY
                }
        // 버섯 오른쪽 이동 시작
        withAnimation(
            Animation.linear(duration: AnimationConst.Mushroom.lifeDuration - AnimationConst.Mushroom.upDuration)
                .delay(AnimationConst.Mushroom.upDuration)) {
                    mushroomX = AnimationConst.Mushroom.maxX
                }
    }
}

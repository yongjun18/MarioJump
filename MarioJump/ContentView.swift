//
//  ContentView.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/14.
//

import SwiftUI

struct AnimationConst {
    struct Mario {
        public static let initY = -145.0
        public static let maxY = -270.0
    }
    struct Box {
        public static let initY = -350.0
        public static let maxY = -400.0
    }
    struct Coin {
        public static let initY = -350.0
        public static let maxY = -500.0
    }
}

struct ContentView: View {
    @State private var animating = false
    @State private var marioAnimating = false
    @State private var marioY = AnimationConst.Mario.initY
    @State private var boxY = AnimationConst.Box.initY
    @State private var coinY = AnimationConst.Coin.initY
    
    var body: some View {
        ZStack {
            // 배경 이미지 설정
            VStack(spacing: 0) {
                Color(red: 107/255, green: 141/255, blue: 255/255)
                Image("bg-image")
            }
            
            ZStack {
                Image(marioAnimating ? "mario-jump" : "mario")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(y: marioY)
                
                Image("mario-coin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .offset(y: coinY)
                
                Image("mario-box")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .offset(y: boxY)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .ignoresSafeArea()
        // 화면 전체에서 터치 이벤트 받기
        .contentShape(Rectangle())
        .onTapGesture {
            if animating == false {
                marioAnimating = true
                animating = true
                animate()
            }
        }
    }
    
    // 애니메이션 실행
    private func animate() {
        let hitBoxTime = 0.3
        let marioStopTime = 0.5
        
        let boxDropTime = 0.45
        let boxStopTime = boxDropTime + (boxDropTime - hitBoxTime)
        let coinDropTime = 0.48
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
            marioAnimating = false
        }
        
        // 최종 애니메이션 종료
        DispatchQueue.main.asyncAfter(deadline: .now() + coinStopTime) {
            animating = false
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

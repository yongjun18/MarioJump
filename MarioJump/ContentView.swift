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
        public static let maxY = -600.0
    }
}

struct ContentView: View {
    @State private var coinCnt = 0
    @State private var animating = false
    @State private var marioAnimating = false
    @State private var marioY = AnimationConst.Mario.initY
    @State private var boxY = AnimationConst.Box.initY
    @State private var coinY = AnimationConst.Coin.initY
    
    var body: some View {
        ZStack {
            ZStack {
                // 배경 이미지 설정
                VStack(spacing: 0) {
                    Spacer()
                    Image("bg-image")
                }
                .background(Color(red: 107/255, green: 141/255, blue: 255/255))
                
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
            
            // 상단 코인 count 미터기
            VStack {
                HStack(spacing: 0) {
                    Image("mario-coin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding([.leading], 10)
                    Text("X")
                        .font(.custom("DungGeunMo", size: 35))
                        .foregroundColor(.white)
                        .padding([.trailing], 5)
                    Text("\(coinCnt)")
                        .font(.custom("DungGeunMo", size: 35))
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding([.top, .bottom], 10)
                Spacer()
            }
        }
    }
    
    // 애니메이션 실행
    private func animate() {
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
            marioAnimating = false
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
            coinCnt += 1
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
            animating = false
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/14.
//

import SwiftUI

struct ContentView: View {
    private var animating = false
    @State private var marioY = -145.0
    @State private var boxY = -350.0
    @State private var coinY = -350.0
    
    var body: some View {
        ZStack {
            // 배경 이미지 설정
            VStack(spacing: 0) {
                Color(red: 107/255, green: 141/255, blue: 255/255)
                Image("bg-image")
            }
            
            ZStack {
                Image(animating ? "mario-jump" : "mario")
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
            print("tapped")
        }
    }
    
    // 애니메이션 실행
    private func animate() {
        let hitBoxTime = 0.3
        let marioStopTime = 0.5
        
        let boxDroppingTime = 0.45
        let boxStopTime = boxDroppingTime + (boxDroppingTime - hitBoxTime)
        let coinDroppingTime = 0.48
        let coinStopTime = coinDroppingTime + (coinDroppingTime - hitBoxTime)
        
        let maxMarioY = -270
        let maxBoxY = -400
        let maxCoinY = -500
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

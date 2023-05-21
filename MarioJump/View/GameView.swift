//
//  GameView.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/21.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameVM: GameViewModel
    
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
                    Image(gameVM.marioAnimating ? "mario-jump" : "mario")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .offset(y: gameVM.marioY)
                    
                    Image("mario-coin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .offset(y: gameVM.coinY)
                    
                    Image("mario-box")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .offset(y: gameVM.boxY)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .ignoresSafeArea()
            // 화면 전체에서 터치 이벤트 받기
            .contentShape(Rectangle())
            .onTapGesture {
                if gameVM.animating == false {
                    gameVM.marioAnimating = true
                    gameVM.animating = true
                    gameVM.animate()
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
                    Text("\(gameVM.coinCnt)")
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
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameViewModel())
    }
}

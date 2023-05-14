//
//  ContentView.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // 배경 이미지 설정
            VStack(spacing: 0) {
                Color(red: 107/255, green: 141/255, blue: 255/255)
                Image("bg-image")
            }
            
            ZStack {
                Image("mario")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(y: -145)
                
                Image("mario-jump")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(y: -270)
                
                Image("mario-box")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .offset(y: -350)
                
                Image("mario-coin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .offset(y: -450)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

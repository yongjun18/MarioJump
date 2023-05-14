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
            VStack(spacing: 0) {
                Color(red: 107/255, green: 141/255, blue: 255/255)
                Image("bg-image")
            }
            .ignoresSafeArea()
            
            Image("mario-jump")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Image("mario")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Image("mario-box")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

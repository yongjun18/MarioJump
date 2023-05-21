//
//  MarioJumpApp.swift
//  MarioJump
//
//  Created by yongjun18 on 2023/05/14.
//

import SwiftUI

@main
struct MarioJumpApp: App {
    var body: some Scene {
        WindowGroup {
            GameView().environmentObject(GameViewModel())
        }
    }
}

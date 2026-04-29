//
//  MakeAPlay.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/27/26.
//
import SwiftUI
import SpriteKit

struct MakeAPlay: View {
    var body: some View {
        SpriteView(
            scene: BasketballGameScene(
                size: CGSize(width: 390, height: 844)
            )
        )
        .ignoresSafeArea()
    }
}

//
//  GolfGame.swift
//  Sports
//
//  Created by Oleksandr Andrusyshyn on 4/23/26.
//
import SwiftUI
import SpriteKit

struct GolfGame: View {
    var body: some View {
        GeometryReader() { geometry in
            SpriteView(scene: GameScene(size: geometry.size))
        }
    }
}

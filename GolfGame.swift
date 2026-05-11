//
//  GolfGame.swift
//  Sports
//
//  Created by Oleksandr Andrusyshyn on 4/23/26.
//
import SwiftUI
import SpriteKit

struct GolfGame: View {
    
    @State var power: CGFloat = 1

    var body: some View {
        HStack {
            GeometryReader() { geometry in
                SpriteView(scene: GameScene(size: geometry.size))
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar){
                
                Slider(value: $power, in: 1...10) {_ in
                    print("\(power)")
                }
            }
        }
    }
}

//
//  GolfGame.swift
//  Sports
//
//  Created by Oleksandr Andrusyshyn on 4/23/26.
//
import SwiftUI
import SpriteKit

struct GolfGame: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var power: CGFloat = 1

    var body: some View {
        Button{
            dismiss()
        } label: {
            Text("🏠")
                .font(.custom("", size: 60))
        }
        HStack {
            GeometryReader() { geometry in
                SpriteView(scene: GameScene(powers: $power, size: geometry.size))
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar){
                
                Slider(value: $power, in: 1...10, step: 1.0) {_ in
                    print("\(power)")
                }
                .frame(width: .infinity)
                .padding()
            }
        }
    }
}

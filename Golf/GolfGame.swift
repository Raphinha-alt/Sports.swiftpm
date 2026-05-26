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
    
    @State var pickedClub = "Driver"
    let clubs = ["Driver", "Iron", "Putter"]
    
    var body: some View {
        Button{
            dismiss()
        } label: {
            Text("🏠")
                .font(.custom("", size: 60))
        }
        ZStack {
            GeometryReader() { geometry in
                SpriteView(scene: GameScene(powers: $power, clubSpecific: $pickedClub, size: geometry.size))
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Slider(value: $power, in: 1...10, step: 1.0) {_ in
                    print("\(power)")
                }
                .frame(width: .infinity)
                .padding()
            }
            ToolbarItem(placement: .topBarLeading){
                Picker("Pick your club", selection: $pickedClub){
                    ForEach(clubs, id: \.self){ club in
                        Text(club).tag(club)
                            .font(.custom("My", size: 100))
                    }
                }
            }
        }
    }
}


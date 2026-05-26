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
    
    @State private var power: CGFloat = 1
    @State private var restart = UUID()
    
    @State var pickedClub = "Driver"
    let clubs = ["Driver", "Iron", "Putter"]
    
    var body: some View {
        HStack (alignment: .top, spacing: 400){
            Button{
                dismiss()
            } label: {
                VStack{
                    Text("🏠")
                        .font(.custom("", size: 80))
                    Text("Home")
                        .font(.largeTitle)
                }
            }
            
            Button {
                restart = UUID()
            } label: {
                VStack{
                    Image(systemName: "repeat")
                        .font(.custom("", size: 80))
                    Text("Restart")
                        .font(.largeTitle)
                }
            }
        }
        ZStack{
            ZStack {
                GeometryReader() { geometry in
                    SpriteView(scene: GameScene(powers: $power, clubSpecific: $pickedClub, size: geometry.size))
                }
                .id(restart)
            }
            .toolbar {
                
                ToolbarItem(placement: .bottomBar) {
                    Slider(value: $power, in: 1...10, step: 1.0) {_ in
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
}


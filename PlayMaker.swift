//
//  PlayMaker.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/23/26.
//
import SwiftUI

struct MakeAPlay: View {
    @State private var selectedPlay: DefensivePlay = .manToMan
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Select Defensive Play")
                .font(.headline)
            
            Picker("Defensive Play", selection: $selectedPlay) {
                ForEach(DefensivePlay.allCases) { play in
                    Text(play.rawValue).tag(play)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Text("Selected: \(selectedPlay.rawValue)")
                .padding()
        }
        .padding()
        Text("Make a play")
    }
    
    
    enum DefensivePlay: String, CaseIterable, Identifiable {
        case manToMan = "Man-to-Man"
        case zone23 = "2-3 Zone"
        case zone32 = "3-2 Zone"
        case zone131 = "1-3-1 Zone"
        case boxAndOne = "Box-and-One"
        case triangleAndTwo = "Triangle-and-Two"
        case fullCourtPress = "Full-Court Press"
        case halfCourtPress = "Half-Court Press"
        case trapDefense = "Trap Defense"
        case switchEverything = "Switch Everything"
        case dropCoverage = "Drop Coverage"
        case hedgeAndRecover = "Hedge and Recover"
        case iceDefense = "ICE (Side Pick-and-Roll)"
        case denyDefense = "Deny Defense"
        case packLine = "Pack Line"
        
        var id: String { self.rawValue }
    }
}

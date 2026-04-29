//
//  Players.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 4/27/26.
//

import SwiftUI

struct SoccerPlayers: View {
    @State var choices = ["messi", "ronaldo", "Lewa"]
    @State var choice = ["neymar", "Kroos", "Iniesta"]
    @State var pick = "mark"
    @State var result: String = ""
    @State var playerChoice: String = ""
    
    var body: some View {
        Text("Pick a Player")
            .font(.largeTitle)
        
        VStack {
            Text("Player Choice")
            Image(pick)
                .resizable()
                .frame(width: 250, height: 250)
            
                .padding(40)
            
            Text(result)
            
            HStack {
                ForEach(choice.indices, id: \.self) { index in
                    Image(choice[index])
                        .resizable()
                        .frame(width: 150, height: 150)
                        .onTapGesture {
                            let selected = choice[index]
                            pick = selected
//
                            if selected == "neymar" {
                                result = "Matches, 720, goals- 440, assists- 260, trohpieds-30"
                                
                            }
                            else if selected == "Kroos" {
                                result = "Matches-750, goals-75, assists-165, trohpies-30"
                            }
                            else{
                                
                                result = "matches-900, goals-110, assists-190, trophiies-35"
                            }
                        }
                }
            }
            
            .padding(30)
            HStack {
                ForEach(choices.indices, id: \.self) { index in
                    Image(choices[index])
                        .resizable()
                        .frame(width: 150, height: 150)
                        .onTapGesture {
                            let Selected = choices[index]
                            pick = Selected
                            
                            if Selected == "messi" {
                                result = "matches-1050+, goals-902, assists-407, trophies-45"
                            }
                            else if Selected == "ronaldo" {
                                result = "matches-1317, goals-969, assists-261, trohpies-37"
                            }
                            else{
                                
                                result = "matches 800=, goals-650+, assists-150+, trohpies- 25+"
                            }
                            
                        }
                }
            }
        }
        NavigationLink("🏠") {
            ContentView()
        }
        .font(.custom("house", fixedSize:90))
    }
}

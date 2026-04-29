//
//  Teams.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 4/27/26.
//

//
//  Players.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 4/27/26.
//

import SwiftUI

struct Soccerteams: View {
    @State var choices = ["barca", "madrid", "bayern"]
    @State var choice = ["liverpool", "milan", "Paris"]
    @State var pick = "mark"
    @State var result: String = ""
    @State var playerChoice: String = ""
    
    var body: some View {
        Text("Pick a Team")
            .font(.largeTitle)
        
        VStack {
            Text("Team Choice")
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
                            if selected == "liverpool" {
                                result = "20 premier leauges, 6 ucls, 10 league cups, 8 FA cups, 3 europa league, 1 fifa intercontintential cup, 4 super cups, 16 community shields"
                                
                            }
                            else if selected == "milan" {
                                result = "7 Ucls, 5 Coppa Italia, 8 Suppercoppa Italian, 5 super cups, 3 intercontiental cups"
                            }
                            else{
                                
                                result = "1 Ucl, 1 super cup, 1 intercontinental cup, 13 ligue 1's, 16 Coupe de France,14 Trophee des Champions, 9 Couoe de la ligue"
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
                            
                            if Selected == "barca" {
                                result = "5 ucls, 28 laligas, 32 cdr, 16SCDE, 5 Uefa supercup,3 fifa intercontiential cup"
                            }
                            else if Selected == "madrid" {
                                result = "15 ucls,2 europa leagues,  36 laligas, 20 CDR, 13 SCDE, 6 Uefa supercup, 8 fifa intercontiential cup"
                            }
                            else{
                                
                                result = "6ucls, 34 bundesligas, 20DFb-pokls, 10 DFLsupercups, 2 Uefa supercup, 2 fifa intercontiential cup"
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

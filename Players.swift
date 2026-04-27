//
//  Players.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 4/27/26.
//

import SwiftUI

struct SoccerPlayers: View {
    @State var choice = "mark"
    var body: some View {
        Text("Click on the players for information")
            .font(.largeTitle)
        HStack{
            Text("Your pick")
            Image(choice)
                .resizable()
                .frame(width: 200,height: 200)
                
        }
        VStack{
            
        }
    }
}

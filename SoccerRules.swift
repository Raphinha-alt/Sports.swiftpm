//
//  SoccerRules.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 4/21/26.
//
import SwiftUI

struct RuleView: View {
    var body: some View {
      Text("Soccer Rules")
            .font(.custom("football", fixedSize: 60))
        VStack{
            Text("MatchDuration- 90 full minutes")
            Text("2 45 havles- 45 minutes played, break, another 45 minutes then game over")
            Text("Injury time- time added to both 45 minute halves for lost time")
            Text("Extra time- 30 extra minutes if game ends in draw during knockouts")
            Text("Team outfielding- 11 players walk out for both teams, minimum 7 player requirement ")
            Text("100-130 yard length, 50-100 yard width")
            
        }
    }
}

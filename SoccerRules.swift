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
            Text("1. MatchDuration- 90 full minutes")
            Text("2. 2 45 havles- 45 minutes played, break, another 45 minutes then game over")
            Text("3. Injury time- time added to both 45 minute halves for lost time")
            Text("4. Extra time- 30 extra minutes if game ends in draw during knockouts")
            Text("5. Team outfielding- 11 players walk out for both teams, minimum 7 player requirement ")
            Text("6. 100-130 yard length, 50-100 yard width")
            Text("7. Throw in- teams recieves ball and throws in to a teammate, determined who kicked it out on the length side")
            Text("8. Corner Kick- kick from the corner of the field, determined if the ball was kicked out by the team on their own side")
            Text("9. Sides- first 45 minutes each team starts on one side then switches after half time")
            Text("10. Cards- yellow and red, yellow is warning, red is out for the rest of the game and miss next game, back to back yellow misses the next game to")
            Text("11. Fouls- an unfair physical infraction against an opponent, judged by the referee, resulting in a direct or indirect free kick (or penalty) for the opposing team")
        }
    }
}

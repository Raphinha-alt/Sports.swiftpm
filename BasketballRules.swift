//
//  BasketballRules.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/21/26.
//
import SwiftUI

struct BasketballRules: View {
    @AppStorage("agreedToRules") var agreedToRules = false
    
    var body: some View {
        if agreedToRules {
            PlayMaker()
        } else {
            VStack {
                Text("Basketball Rules")
                    .font(.system(size: 40, weight: .bold))
                    .padding()
                
                ScrollView {
                    Text("""
                    BASKETBALL RULES
                    
                    1. Objective:
                    Score points by shooting the ball through the opponent’s hoop.
                    
                    2. Teams:
                    Each team has 5 players on the court.
                    
                    3. Scoring:
                    - 1 point: Free throw
                    - 2 points: Inside the 3-point line
                    - 3 points: Beyond the 3-point line
                    
                    4. Dribbling:
                    You must dribble while moving. No running with the ball.
                    
                    5. Violations:
                    Traveling, double dribble, and backcourt are not allowed.
                    
                    6. Fouls:
                    Illegal contact results in fouls and possible free throws.
                    
                    7. Game Length:
                    Played in quarters. Team with most points wins.
                    """)
                    .padding()
                }
                
                Button("Agree to Rules") {
                    agreedToRules = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}

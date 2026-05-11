//
//  GolfRules.swift
//  Sports
//
//  Created by Oleksandr Andrusyshyn on 4/23/26.
//
import SwiftUI

struct GolfRules: View {
    var body: some View {
        NavigationStack{
            Text("Golf Rules")
                .font(.custom("", size: 60))
                
            VStack(alignment: .leading, spacing: 4){
                
                            
                List{
                    Text("Main rules:")
                        .bold()
                        .font(.largeTitle)
                    Text("""
                    1) Start in within the tee box, between the designated markers and no longer than too clubs behind.
                    2) Play the ball as it lies.
                    3) In penalty areas you can play as it lies or take a relief and get a one-stroke penalty.
                    4) You can lift the ball to clean it but it must be put on the exact same place.
                    5) If you cannot find your ball in 3 minutes or it went out of bounds, you must replay the shot from the previous spot taking a one-stroke penalty.
                    6) You can carry no more than 14 clubs.
                    """)
                    .font(.custom("", size: 24))
                    
                    Text("Penalties:")
                        .bold()
                        .font(.largeTitle)
                    
                    Text("""
                    1) One Stroke: Penalty areas, lost ball, taking unplayable lie, or moving your ball during practice swing.
                    2) Two strokes: Given for playing from the wrong place, playing wrong ball, or violating rule in a bunker.
                    3) Disqualification: Given for submitting lower score or consistent breaches of etiquette.
                    """)
                    .font(.custom("", size: 24))
                    
                    Text("Etiquette:")
                        .bold()
                        .font(.largeTitle)
                    
                    Text("""
                    1) Shout “Fore!” If your ball heading toward other golfers.
                    2) Do not disturb others when they prepare to hit.
                    3) Always be ready to play and keep up with the group in front.
                    4) Repair divots, smooth bunker sand, and fix ball marks.
                    """)
                    .font(.custom("", size: 24))
                    
                    Text("Clubs:")
                        .bold()
                        .font(.largeTitle)
                    
                    Text("""
                    1) Driver: Used for maximum distance off the tee.
                    2) Fairway woods: For long shots from the fairway or rough.
                    3) Hybrids: Replacement for long irons with better control and easier launch.
                    4) Irons: Used to approach shots to the green.
                    5) Wedges: Specialized clubs for short-game shots, including pitching, gap, sand, and lob wedges.
                    6) Putter: Short range hits on green to roll the ball into the hole.
                    """)
                    .font(.custom("", size: 24))
                }
                
                
                
            }
            NavigationLink("Go to golf game") {
               GolfGame()
            }
            .font(.custom("golfball", fixedSize: 25))
        }
    }
}

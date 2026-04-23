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
                .font(.largeTitle)
                .bold()
            VStack(alignment: .leading, spacing: 4){
                
                Text("Main rules:")
                    .bold()
                Text("""
                Start in within the tee box, between the designated markers and no longer than too clubs behind.
                Play the ball as it lies.
                In penalty areas you can play as it lies or take a relief and get a one-stroke penalty.
                You can lift the ball to clean it but it must be put on the exact same place.
                If you cannot find your ball in 3 minutes or it went out of bounds, you must replay the shot from the previous spot taking a one-stroke penalty.
                You can carry no more than 14 clubs.
                """)
                .font(.custom("", size: 14))
                
                Text("Penalties:")
                    .bold()
                Text("""
                One Stroke: Penalty areas, lost ball, taking unplayable lie, or moving your ball during practice swing.
                Two strokes: Given for playing from the wrong place, playing wrong ball, or violating rule in a bunker.
                Disqualification: Given for submitting lower score or consistent breaches of etiquette.
                """)
                .font(.custom("", size: 14))
                
                Text("Etiquette:")
                    .bold()
                Text("""
                Shout “Fore!” If your ball heading toward other golfers.
                Do not disturb others when they prepare to hit.
                Always be ready to play and keep up with the group in front.
                Repair divots, smooth bunker sand, and fix ball marks.
                """)
                .font(.custom("", size: 14))
                
                Text("Clubs:")
                    .bold()
                Text("""
                Driver: Used for maximum distance off the tee.
                Fairway woods: For long shots from the fairway or rough.
                Hybrids: Replacement for long irons with better control and easier launch.
                Irons: Used to approach shots to the green.
                Wedges: Specialized clubs for short-game shots, including pitching, gap, sand, and lob wedges.
                Putter: Short range hits on green to roll the ball into the hole.
                """)
                .font(.custom("", size: 14))
            }
            NavigationLink("Go to golf game") {
               GolfGame()
            }
            .font(.custom("golfball", fixedSize: 25))
        }
    }
}

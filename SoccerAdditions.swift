//
//  SoccerAdditions.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 4/23/26.
//

import SwiftUI

struct Soccermore: View {
    var body: some View {
        Text("Learn more about Soccer")
            .font(.custom("more", size: 90))
        Text("(Clink on the icons)")
        
        
            .padding()
        
        VStack{
            HStack{
                
                
                NavigationLink("🏆") {
                    SoccerComps()
                }
                .font(.custom("Trophy", fixedSize: 155))
                
                .padding(100)
                NavigationLink(destination: SoccerPlayers()) {
                    Image("Lewa")
                        .resizable()
                        .frame(width: 250, height: 250)
                }
            }
        }
        
            .padding(40)
        
        VStack{
            HStack{
            NavigationLink("📖") {
                SoccerHistory()
            }
            .font(.custom("History", fixedSize: 125))
            
            .padding(100)
                NavigationLink(destination: Soccerteams()) {
                    Image("Paris")
                        .resizable()
                        .frame(width: 250, height: 250)
                }
            }
            NavigationLink("🏠") {
                ContentView()
            }
            .font(.custom("house", fixedSize:90))
        }
      
    }
}

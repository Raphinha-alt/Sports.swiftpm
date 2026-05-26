//
//  Groups.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 5/21/26.
//

import SwiftUI

struct Stages: View {
    var body: some View {
        Text("What you can learn before June 11th")
            .font(.custom("", size: 60))
        HStack{
            VStack{
                Text("Groups/ all teams")
                Image("Teams")
                    .resizable()
                    .frame(width: 550, height: 550, alignment: .center)
                
                Text("Current Ranks")
                Image("Ranks")
                    .resizable()
                    .frame(width: 450, height: 450, alignment: .center)
                

            }
            VStack{
                Text("Big Teams")
                Image("Favorites")
                    .resizable()
                    .frame(width: 450, height: 450, alignment: .center)
            }
        }
        
    }
}

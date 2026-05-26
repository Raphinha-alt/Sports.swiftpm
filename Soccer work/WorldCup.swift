//
//  WorldCup.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 5/21/26.
//

import SwiftUI

struct WorldCup: View {
    var body: some View {
        Text("World Cup Knowledge")
            .font(Font.largeTitle.bold())
        HStack{
            VStack{
                Text("Current holder")
                Image("Argentina")
                    .resizable()
                    .frame(width: 400,height: 400)
                
                Text("All time winners")
                Image("Worldwin")
                    .resizable()
                    .frame(width: 400,height: 400)
            }
            
        }
        
    }
}

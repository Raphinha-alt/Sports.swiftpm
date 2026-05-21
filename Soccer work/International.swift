//
//  International.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 5/19/26.
//

import SwiftUI

struct International: View {
    var body: some View {
        Text("International football")
            .font(.largeTitle)
            
        Text("Getting hyped for the 2026 World Cup")
            .font(.custom("Getting hyped for the 2026 World Cup", size: 100))
        Image("World")
            .resizable()
            .frame(width: 600,height: 400)
        
        NavigationLink("➡️") {
         WorldCup()
        }
        .font(.custom("arrow", fixedSize: 80))
        }
    }

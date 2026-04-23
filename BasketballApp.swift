//
//  BasketballApp.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/23/26.
//
import SwiftUI

struct PlayMaker: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Text("Welcome to PlayMaker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: PlayList()) {
                    Text("Go to Your Playlist")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                NavigationLink(destination: MakeAPlay()) {
                    Text("Go Make a Play")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Spacer()
            }
        }
    }
}

//
//  BasketballApp.swift
//  Sports
//
//  Created by Oskar Fabisiak on 4/23/26.
//
import SwiftUI

struct PlayMaker: View {
    var body: some View {
        Text("Welcome To Playmaker!!")
        
        NavigationLink("Go to your Playlist") {
            PlayList()
        }
        
        NavigationLink("Go Make A Play") {
            PlayMaker()
        }
    }
}


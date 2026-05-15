//
//  soccerrials.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 5/7/26.
//


import SwiftUI

struct Rivals: View {
    @State var showAlert1 = false
    @State var showAlert2 = false
    @State var showAlert3 = false
    @State var showAlert4 = false
    @State var R1 = ["madrid", "sword", "bayern"]
    @State var R2 = ["barca", "sword", "milan"]
    @State var R3 = ["Chelsea", "sword", "United"]
    @State var R4 = ["liverpool", "sword", "City"]
    var body: some View {
        Text("Biggest Uefa Rivalries")
            .font(.largeTitle)
        VStack {
            HStack{
                ForEach(R1.indices, id: \.self) { index in
                    Image(R1[index])
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                Button("Show Stats") {
                    showAlert1.toggle()
                }
        .font(.largeTitle)
        .frame(width: 150, height: 150)
        .background(Color.red)
        .foregroundColor(.blue)
                                    
        .alert("Matches played: 30, Madrid wins: 13, Bayern wins: 13, Draws: 4", isPresented: $showAlert1) {
                                    }
            }
            .padding(35)
            HStack{
                ForEach(R2.indices, id: \.self) { index in
                    Image(R2[index])
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                Button("Show Stats") {
                    showAlert2.toggle()
                }
        .font(.largeTitle)
        .frame(width: 150, height: 150)
        .background(Color.red)
        .foregroundColor(.blue)
        .alert("Matches played: 15, Barca wins: 7, Milan wins: 3, Draws: 5", isPresented: $showAlert2) {
                                    }
            }
            .padding(35)
            HStack{
                ForEach(R3.indices, id: \.self) { index in
                    Image(R3[index])
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                Button("Show Stats") {
                    showAlert3.toggle()
                }
        .font(.largeTitle)
        .frame(width: 150, height: 150)
        .background(Color.red)
        .foregroundColor(.blue)
        .alert("Matches played: 195, Chelsea wins: 56, United wins: 83, Draws: 56", isPresented: $showAlert3) {
                                    }
            }
            .padding(35)
            HStack{
                ForEach(R4.indices, id: \.self) { index in
                    Image(R4[index])
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                Button("Show Stats") {
                    showAlert4.toggle()
                }
        .font(.largeTitle)
        .frame(width: 150, height: 150)
        .background(Color.red)
        .foregroundColor(.blue)
        .alert("Matches played: 221, liverpool wins: 110, City wins: 63, Draws: 58", isPresented: $showAlert4) {
                                    }
            }
        }
        NavigationLink("🏠") {
            ContentView()
        }
        .font(.custom("house", fixedSize:80))
    }
}

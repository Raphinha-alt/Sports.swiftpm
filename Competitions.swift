//
//  Competitions.swift
//  Sports
//
//  Created by Andrew S. Zhundrikov on 4/27/26.
//

import SwiftUI

struct SoccerComps: View {
    let myURL = URL(string: "https://en.wikipedia.org/wiki/UEFA_Champions_League")!
    let myURL2 = URL(string: "https://en.wikipedia.org/wiki/UEFA_Europa_League")!
    let myURL3 = URL(string: "https://en.wikipedia.org/wiki/UEFA_Conference_League")!
    let myURL4 = URL(string: "https://en.wikipedia.org/wiki/UEFA_Super_Cup")!
    let myURL5 = URL(string: "https://en.wikipedia.org/wiki/FIFA_Intercontinental_Cup")!
    let myURL6 = URL(string: "https://www.fifa.com/en/tournaments/mens/club-world-cup/usa-2025")!
    let myURL7 = URL(string: "https://www.uefa.com")!
    var body: some View {
            VStack{
            Text("Learn about these competitions")
                .font(.largeTitle)
            Text("(Click on each image)")
            
            Link("Offical UEFA Page", destination: myURL7)
            }
            
        HStack{
            VStack{
                
                Link(destination: myURL) {
                    Image("UCL")
                        .resizable()
                        .frame(width: 250, height: 250)
                }
                
                Link(destination: myURL2) {
                    Image("europa")
                        .resizable()
                        .frame(width: 250, height: 250)
                }
                
                Link(destination: myURL3) {
                    Image("conference")
                        .resizable()
                        .frame(width: 250,height: 250)
                }
                
                .padding(50)
            }
            VStack{
                Link(destination: myURL4) {
                    Image("super")
                        .resizable()
                        .frame(width: 250,height: 250)
                }
                    Link(destination: myURL5) {
                        Image("inter")
                            .resizable()
                            .frame(width: 250,height: 250)
                    }
                        Link(destination: myURL6) {
                            Image("club")
                                .resizable()
                                .frame(width: 250,height: 250)
                        }
            }
            
        }
        NavigationLink("🏠") {
            ContentView()
        }
        .font(.custom("house", fixedSize:90))
    }
}

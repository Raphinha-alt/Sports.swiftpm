import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            
            
            Text("Welcome")
                .font(.largeTitle)
            Text("Select Your Sport")
                .font(.largeTitle)
            Text("(click the icon)")
                .font(.title)
            
            
            
            
            
            VStack(spacing:50) {
                
                
                NavigationLink("🏀") {
                    BasketballRules()
                }
                .font(.custom("football", fixedSize: 125))
                
                
                NavigationLink("⚽️") {
                    RuleView()
                }
                .font(.custom("football", fixedSize: 125))
                
                Button("⛳️") {
                    
                }
                .font(.custom("basketball", fixedSize: 125))
            }
        }
    }
}


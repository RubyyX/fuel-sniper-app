//
//  ContentView.swift
//  Fuel Sniper
//
//  Created by Ethan Colgan on 24/11/21.
//

import SwiftUI

struct ContentView: View {
    @State var circleProgress: CGFloat = 1
    @State var avgPrice: CGFloat = 40.26
    
    var ratings = ["Bad", "Average", "Good"]
  
    
    var body: some View {
        VStack(){
            //The guage and reading of avg city price
            ZStack()
            {
                Circle()
                    .trim(from: 0.0, to: circleProgress/4*3)
                    .stroke(Color.blue, lineWidth: 15)
                    .frame(width: 150, height: 150)
                    .rotationEffect(Angle(degrees: -225))
                Text("\(Int(self.avgPrice))")
                    .font(.custom("HelveticaNeue", size: 40.0))
            }
            .padding(.top, 100)
            //rating based on circle progress
            Text(ratings[Int(circleProgress*3)-1])
                
            Divider()
            Spacer()
        }.edgesIgnoringSafeArea(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

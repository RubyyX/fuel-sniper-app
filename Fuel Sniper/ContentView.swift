//
//  ContentView.swift
//  Fuel Sniper
//
//  Created by Ethan Colgan on 24/11/21.
//

import SwiftUI

struct ContentView: View {
    @State var circleProgress: CGFloat = 0.8
    @State var avgPrice: CGFloat = 40.26
    //animation value
    @State private var animationAmount: CGFloat = 0
    
    var ratings = ["Bad", "Average", "Good"]

    
    var body: some View {
        VStack(){
            
            //The guage and reading of avg city price
            ZStack()
            {
                //grey background circle
                Circle()
                    .trim(from: 0.0, to: 1/4*3)
                    .stroke(Color(UIColor.lightGray), lineWidth: 15)
                    .frame(width: 150, height: 150)
                    .rotationEffect(Angle(degrees: -225))
                   
                //guage circle
                Circle()
                    .trim(from: 0.0, to: animationAmount * (circleProgress/4*3))
                    .stroke(Color(UIColor(hue: CGFloat(circleProgress) / 3, saturation: 1.0, brightness: 1.0, alpha: 1.0)), lineWidth: 15)
                    .frame(width: 150, height: 150)
                    .rotationEffect(Angle(degrees: -225))
                
                //average price text
                Text("\(Int(self.avgPrice))")
                    .font(.custom("HelveticaNeue", size: 40.0))
            }
            .padding(.top, 100)
            
            //rating based on circle progress
            if circleProgress == 0
            {
                Text(ratings[0])
            }
            else
            {
                Text(ratings[Int(ceil(circleProgress*3))-1])
            }
            
            Divider()
            Spacer()
        }
            .edgesIgnoringSafeArea(.all)
            .onAppear
            {
                //appear animation animationamount is CGFloat 0-1
                withAnimation(Animation.easeOut(duration: 1))
                {
                    animationAmount = 1
                }
            }
            .onDisappear
            {
                animationAmount = 0
            }
    }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

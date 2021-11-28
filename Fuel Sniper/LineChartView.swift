//
//  LineChartView.swift
//  Fuel Sniper
//
//  Created by Ethan Colgan on 28/11/21.
//

import SwiftUI

struct LineChartView: View {
    
    let values: [Int]
    let labels: [String]
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path { //Using a Path variable to create a line connecting points in array
        if values.isEmpty {
            return Path()
        }
        
        var offsetX: Int = Int(screenWidth/CGFloat(values.count)) //x distance
        var path = Path()
        path.move(to: CGPoint(x: offsetX, y: values[0]))
        
        for value in values.dropFirst() {
            offsetX += Int(screenWidth/CGFloat(values.count))
            path.addLine(to: CGPoint(x: offsetX, y: value))
        }
        return path
    }
    
    var body: some View {
        VStack {
            path.stroke(Color.white, lineWidth: 2.0)
                .rotationEffect(.degrees(180), anchor: .center) //Rotation moves graph to bottom
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0)) //Flips graph direction back
                .frame(maxWidth: .infinity, maxHeight: 250) //Vertical placement of graph
            
            HStack {
                ForEach(labels, id: \.self) {
                    label in Text(label).frame(width: screenWidth/CGFloat(labels.count) - 10)
                }
            }
        }
    }
}

//struct LineChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        LineChartView()
//    }
//}

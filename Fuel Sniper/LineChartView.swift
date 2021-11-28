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
        if values.isEmpty { //If no prices then no graph
            return Path()
        }

        var offsetX: Int = Int(screenWidth / CGFloat(values.count)) //x distance
        var path = Path()
        path.move(to: CGPoint(x: offsetX, y: values[0]))

        for value in values.dropFirst(3) { //The 3 fits the path horizontally within the vstack idk why. I think it's because the path was built using the screenwidth as bounds we need to use the width of the vstack instead???
            offsetX += Int(screenWidth / CGFloat(values.count))
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

            HStack(spacing: 5) {
                ForEach(labels, id: \.self) {
                    label in Text(label).frame(width: screenWidth / CGFloat(labels.count) - 10).padding(.bottom, 5)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  TwoColorPatternBackground.swift
//  
//
//  Created by Denis Cherniy on 05.08.2021.
//

import SwiftUI

public struct TwoColorPatternBackground: View {
    
    let numberOfRepetitions: Int
    let firstColor: Color
    let secondColor: Color
    
    public init(numberOfRepetitions: Int,
                firstColor: Color,
                secondColor: Color) {
        self.numberOfRepetitions = numberOfRepetitions
        self.firstColor = firstColor
        self.secondColor = secondColor
    }
    
    public var body: some View {
        VStack(spacing: 0 ) {
            ForEach(0..<numberOfRepetitions) { number in
                let isEven = number % 2 == 0
                
                Group {
                    isEven ? firstColor : secondColor
                }
            }
        }
    }
}

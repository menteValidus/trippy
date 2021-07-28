//
//  AddWaypoint.swift
//  Trippy
//
//  Created by Denis Cherniy on 28.07.2021.
//

import SwiftUI
import TrippyUI

struct AddWaypoint: View {
    
    typealias ButtonAction = () -> Void
    
    // MARK: - Constants
    
    private let addButtonDiameter: CGFloat = 60
    
    // MARK: - Public Properties
    
    let buttonAction: ButtonAction
    
    var body: some View {
        Button(action: addTapped, label: {
            Circle()
                .frame(width: addButtonDiameter,
                       height: addButtonDiameter)
                .foregroundColor(Asset.Color.Button.background.color)
                .overlay(Asset.Image.plus.image)
        })
    }
}

// MARK: - Actions

private extension AddWaypoint {
    
    func addTapped() {
        buttonAction()
    }
}

struct AddWaypoint_Previews: PreviewProvider {
    static var previews: some View {
        AddWaypoint(buttonAction: { })
            .background(Asset.Color.primaryBackground.color)
            .previewLayout(.sizeThatFits)
    }
}

//
//  GoButton.swift
//  Trippy
//
//  Created by Denis Cherniy on 29.07.2021.
//

import SwiftUI
import UIUtils
import TrippyUI

struct GoButton: View {
    
    // MARK: - Constants
    
    private let buttonWidth: CGFloat = 157
    private let buttonHeight: CGFloat = 60
    
    private let buttonTitleItemsSpacing: CGFloat = 15
    private let buttonTitleFontSize: CGFloat = 25
    
    // MARK: -
    
    let action: ButtonAction
    
    var body: some View {
        Button(action: goButtonTapped, label: {
            RoundedRectangle(cornerRadius: buttonHeight / 2)
                .frame(width: buttonWidth,
                       height: buttonHeight)
                .foregroundColor(Asset.Color.Button.background.color)
                .overlay(buttonTitle())
        })
    }
}

// MARK: - Views

private extension GoButton {
    
    func buttonTitle() -> some View {
        HStack(spacing: buttonTitleItemsSpacing) {
            goTitleText()
            
            Asset.Image.forwardArrow.image
        }
    }
    
    func goTitleText() -> Text {
        Text("_go_button_title")
            .font(.system(size: buttonTitleFontSize))
            .foregroundColor(Asset.Color.Button.text.color)
    }
}

// MARK: - Actions

private extension GoButton {
    
    func goButtonTapped() {
        action()
    }
}

struct GoButton_Previews: PreviewProvider {
    static var previews: some View {
        GoButton(action: { })
            .previewLayout(.sizeThatFits)
            .background(Asset.Color.primaryBackground.color)
    }
}

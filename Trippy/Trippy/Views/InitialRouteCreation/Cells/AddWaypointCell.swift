//
//  AddWaypointCollectionViewCell.swift
//  Trippy
//
//  Created by Denis Cherniy on 26.05.2021.
//

import UIKit
import UIUtils
import TrippyUI
import Stevia

final class AddWaypointCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: - Constants
    
    private let addButtonDiameter: CGFloat = 60
    
    // MARK: - Views
    
    private lazy var addButton: RoundedButton = createAddButton()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        subviews(addButton)
        
        addButton.centerHorizontally()
        addButton.fillVertically()
        addButton.Height == addButtonDiameter
        addButton.Width == addButton.Height
    }
}

// MARK: - Views Creation

private extension AddWaypointCollectionViewCell {
    
    func createAddButton() -> RoundedButton {
        let button = RoundedButton()
        button.backgroundColor = Asset.Color.Button.background.uiColor
        button.setTitleColor(Asset.Color.Button.text.uiColor, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        
        return button
    }
}

#if DEBUG

import SwiftUI

struct AddWaypointCollectionViewCell_Previews: PreviewProvider, UIViewRepresentable {
    
    static var previews: some View {
        Self()
            .background(Asset.Color.primaryBackground.color)
            .previewLayout(.fixed(width: 60, height: 60))
    }
    
    func makeUIView(context: Context) -> some UIView {
        AddWaypointCollectionViewCell()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#endif

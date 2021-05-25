//
//  CornerWaypointCollectionViewCell.swift
//  Trippy
//
//  Created by Denis Cherniy on 25.05.2021.
//

import UIKit
import TrippyUI
import Stevia

class CornerWaypointCollectionViewCell: UICollectionViewCell {
    
    private let waypointDiameter: CGFloat = 22
    
    private lazy var waypointView: WaypointView = createWaypointView()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        subviews(waypointView)
        
        waypointView.Leading == Leading
        waypointView.Top == Top
        waypointView.Height == waypointDiameter
        waypointView.Width == waypointView.Height
    }
}

// MARK: - Views Creation

private extension CornerWaypointCollectionViewCell {
    
    func createWaypointView() -> WaypointView {
        let waypointView = WaypointView(frame: .zero)
        waypointView.backgroundColor = Asset.Color.accent.uiColor
        
        return waypointView
    }
}

#if DEBUG

import SwiftUI

struct CornerWaypointCollectionViewCell_Previews: PreviewProvider, UIViewRepresentable {
    
    static var previews: some View {
        Self()
            .previewLayout(.fixed(width: 314, height: 180))
    }
    
    func makeUIView(context: Context) -> some UIView {
        CornerWaypointCollectionViewCell()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#endif


//
//  IntermediateWaypointCollectionViewCell.swift
//  Trippy
//
//  Created by Denis Cherniy on 27.05.2021.
//

import UIKit
import SwiftUI
import UIUtils
import TrippyUI
import Stevia

struct IntermediateWaypoint: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        IntermediateWaypointView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

final class IntermediateWaypointView: UIView {
    
    // MARK: - Constants
    
    private let waypointDiameter: CGFloat = 22
    
    // MARK: - Views
    
    private lazy var waypointView: CircleView = createWaypointView()
    private lazy var geopointDescriptionLabel: StyledLabel = createGeocodeDescriptionLabel()
    
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
        subviews(
            waypointView,
            geopointDescriptionLabel
        )
        
        configureWaypointView()
        configureGeopointDescriptionLabel()
    }
}

// MARK: - Configuration

private extension IntermediateWaypointView {
    
    func configureWaypointView() {
        waypointView.Leading == Leading
        waypointView.Bottom == geopointDescriptionLabel.FirstBaseline
        waypointView.Height == waypointDiameter
        waypointView.Width == waypointView.Height
    }
    
    func configureGeopointDescriptionLabel() {
        geopointDescriptionLabel.Leading == waypointView.Trailing + 18
        geopointDescriptionLabel.Top == Top
        geopointDescriptionLabel.Bottom == Bottom
    }
}

// MARK: - Views Creation

private extension IntermediateWaypointView {
    
    func createWaypointView() -> CircleView {
        let waypointView = CircleView()
        waypointView.backgroundColor = Asset.Color.accent.uiColor
        
        return waypointView
    }
    
    func createGeocodeDescriptionLabel() -> StyledLabel {
        let label = StyledLabel()
        label.textColor = Asset.Color.Text.primary.uiColor
        label.text = "Taganrog,\nGrecheskaya, 104A"
        label.numberOfLines = 0
        
        return label
    }
}

#if DEBUG

import SwiftUI

struct IntermediateWaypointCollectionViewCell_Previews: PreviewProvider {
    
    static var previews: some View {
        IntermediateWaypoint()
            .background(Asset.Color.primaryBackground.color)
            .previewLayout(.fixed(width: 314, height: 80))
    }
}

#endif

//
//  CornerWaypointCollectionViewCell.swift
//  Trippy
//
//  Created by Denis Cherniy on 25.05.2021.
//

import UIKit
import TrippyUI
import Stevia
import UIUtils

// MARK: - SwiftUI

struct CornerWaypoint: UIViewRepresentable {
    
    let type: CornerWaypointType
    
    func makeUIView(context: Context) -> some UIView {
        CornerWaypointView(type: type)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

enum CornerWaypointType {
    
    case start
    case finish
    
    var title: String {
        switch self {
        case .start:
            return NSLocalizedString("_start_title", comment: "")
        case .finish:
            return NSLocalizedString("_finish_title", comment: "")
        }
    }
}

// MARK: - Corner Waypoint View

final class CornerWaypointView: UIView {
    
    // MARK: - Constants
    
    private let waypointDiameter: CGFloat = 22
    
    // MARK: - Views
    
    private lazy var waypointTypeLabel: UILabel = createWaypointTypeLabel()
    private lazy var waypointView: CircleView = createWaypointView()
    private lazy var geopointDescriptionLabel: StyledLabel = createGeocodeDescriptionLabel()
    
    private lazy var separatorView: HorizontalDashedLineView = createSeparatorView()
    
    private lazy var dateLabel: StyledLabel = createDateLabel()
    
    // MARK: -
    
    private let type: CornerWaypointType
    
    // MARK: - Initialization
    
    init(type: CornerWaypointType) {
        self.type = type
        
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        self.type = .start
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.type = .start
        
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        subviews(
            waypointView,
            waypointTypeLabel,
            geopointDescriptionLabel,
            
            separatorView,
            
            dateLabel
        )
        
        configureWaypointTypeLabel()
        configureWaypointView()
        configureGeopointDescriptionLabel()
        
        configureSeparatorView()
        
        configureDateLabel()
    }
}

// MARK: - Configuration

private extension CornerWaypointView {
    
    func configureWaypointTypeLabel() {
        waypointTypeLabel.Leading == Leading
        waypointTypeLabel.Top == Top
    }
    
    func configureWaypointView() {
        waypointView.Leading == Leading
        waypointView.Top == waypointTypeLabel.Bottom + 22
        waypointView.Height == waypointDiameter
        waypointView.Width == waypointView.Height
    }
    
    func configureGeopointDescriptionLabel() {
        geopointDescriptionLabel.Leading == waypointView.Trailing + 18
        geopointDescriptionLabel.Top == waypointTypeLabel.Bottom + 15
    }
    
    func configureSeparatorView() {
        separatorView.Top == geopointDescriptionLabel.Bottom + 15
        separatorView.fillHorizontally()
    }
    
    func configureDateLabel() {
        dateLabel.Top == separatorView.Bottom + 15
        dateLabel.Bottom == Bottom
        
        dateLabel.Leading == geopointDescriptionLabel.Leading
    }
}

// MARK: - Views Creation

private extension CornerWaypointView {
    
    func createWaypointTypeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = Asset.Color.Text.accent.uiColor
        label.text = type.title
        
        return label
    }
    
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
    
    func createSeparatorView() -> HorizontalDashedLineView {
        let separatorView = HorizontalDashedLineView()
        separatorView.color = Asset.Color.separator.uiColor
        separatorView.lineDashPattern = [22, 20]
        separatorView.lineWidth = 2
        
        return separatorView
    }
    
    func createDateLabel() -> StyledLabel {
        let label = StyledLabel()
        label.textColor = Asset.Color.Text.primary.uiColor
        label.text = "14/08/2021\n6:00"
        label.numberOfLines = 0
        
        return label
    }
}

#if DEBUG

import SwiftUI

struct CornerWaypointCollectionViewCell_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            CornerWaypoint(type: .start)
            
            CornerWaypoint(type: .finish)
        }
        .background(Asset.Color.primaryBackground.color)
        .previewLayout(.fixed(width: 314, height: 220))
    }
}

#endif

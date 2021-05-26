//
//  CornerWaypointCollectionViewCell.swift
//  Trippy
//
//  Created by Denis Cherniy on 25.05.2021.
//

import UIKit
import TrippyUI
import Stevia

public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        String(describing: self) + "ReuseIdentifier"
    }
}

class CornerWaypointCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: - Constants
    
    private let waypointDiameter: CGFloat = 22
    
    // MARK: - Views
    
    private lazy var waypointTypeLabel: UILabel = createWaypointTypeLabel()
    private lazy var waypointView: WaypointView = createWaypointView()
    private lazy var geopointDescriptionLabel: UILabel = createGeocodeDescriptionLabel()
    
    private lazy var separatorView: HorizontalDashedLineView = createSeparatorView()
    
    private lazy var dateLabel: UILabel = createDateLabel()
    
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

private extension CornerWaypointCollectionViewCell {
    
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

private extension CornerWaypointCollectionViewCell {
    
    func createWaypointTypeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textColor = Asset.Color.Text.accent.uiColor
        label.text = "Start"
        
        return label
    }
    
    func createWaypointView() -> WaypointView {
        let waypointView = WaypointView()
        waypointView.backgroundColor = Asset.Color.accent.uiColor
        
        return waypointView
    }
    
    func createGeocodeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
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
    
    func createDateLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = Asset.Color.Text.primary.uiColor
        label.text = "14/08/2021\n6:00"
        label.numberOfLines = 0
        
        return label
    }
}

#if DEBUG

import SwiftUI

struct CornerWaypointCollectionViewCell_Previews: PreviewProvider, UIViewRepresentable {
    
    static var previews: some View {
        Self()
            .background(Asset.Color.primaryBackground.color)
            .previewLayout(.fixed(width: 314, height: 220))
    }
    
    func makeUIView(context: Context) -> some UIView {
        CornerWaypointCollectionViewCell()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#endif

//
//  CornerPointCollectionViewCell.swift
//  Trippy
//
//  Created by Denis Cherniy on 25.05.2021.
//

import UIKit
import TrippyUI

class CornerPointCollectionViewCell: UICollectionViewCell {
    
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
        addSubview(waypointView)
        
        NSLayoutConstraint.activate([
                                        waypointView.topAnchor.constraint(equalTo: topAnchor),
            waypointView.leadingAnchor.constraint(equalTo: leadingAnchor),
            waypointView.widthAnchor.constraint(equalToConstant: waypointDiameter),
            waypointView.heightAnchor.constraint(equalTo: waypointView.widthAnchor)
        ])
    }
}

// MARK: - Views Creation

private extension CornerPointCollectionViewCell {
    
    func createWaypointView() -> WaypointView {
        let waypointView = WaypointView(frame: .zero)
        waypointView.backgroundColor = Asset.Color.accent.uiColor
        waypointView.translatesAutoresizingMaskIntoConstraints = false
        
        return waypointView
    }
}

#if DEBUG

import SwiftUI

struct CornerPointCollectionViewCell_Previews: PreviewProvider, UIViewRepresentable {
    
    static var previews: some View {
        Self()
            .previewLayout(.fixed(width: 314, height: 180))
    }
    
    func makeUIView(context: Context) -> some UIView {
        CornerPointCollectionViewCell()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#endif

class WaypointView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = min(self.bounds.width, self.bounds.height) / 2
    }
}

//
//  HorizontalDashedLineView.swift
//  
//
//  Created by Denis Cherniy on 26.05.2021.
//

import UIKit

public class HorizontalDashedLineView: UIView {
    private var lineLayer: CALayer?
    
    public var color: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var lineDashPattern: [NSNumber] = [] {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var lineWidth: CGFloat? {
        didSet {
            setNeedsLayout()
        }
    }

    public override func layoutSubviews() {
        updateView()
    }

    private func updateView() {
        lineLayer?.removeFromSuperlayer()

        guard let color = color,
              let lineWidth = lineWidth,
              lineDashPattern.count > 0 else { return }
        
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: .init(x: bounds.minX, y: bounds.midY))
        path.addLine(to: .init(x: bounds.maxX, y: bounds.midY))

        layer.path = path.cgPath
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
        layer.lineDashPattern = lineDashPattern
        self.layer.addSublayer(layer)

        lineLayer = layer
    }
}

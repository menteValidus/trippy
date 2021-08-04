//
//  DashedLine.swift
//  Trippy
//
//  Created by Denis Cherniy on 03.08.2021.
//

import UIKit

public final class DashedLine: UIView {
    
    public var color: UIColor? = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var dashPattern: [NSNumber] = [10, 10] {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var dashedLineLayer: CALayer?
    
    public override func layoutSubviews() {
        dashedLineLayer?.removeFromSuperlayer()
        
        let lineDashPattern: [NSNumber]  = [10, 10]

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color?.cgColor
        shapeLayer.lineWidth = bounds.width
        shapeLayer.lineDashPattern = lineDashPattern
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: bounds.midX, y: bounds.minY),
                                CGPoint(x: bounds.midX, y: bounds.maxY)])
        
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
}

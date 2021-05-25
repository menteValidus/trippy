//
//  WaypointView.swift
//  
//
//  Created by Denis Cherniy on 25.05.2021.
//

import UIKit

class WaypointView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = min(self.bounds.width, self.bounds.height) / 2
    }
}

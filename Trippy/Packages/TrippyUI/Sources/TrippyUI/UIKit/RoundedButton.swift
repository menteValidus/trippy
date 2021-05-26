//
//  RoundedButton.swift
//  
//
//  Created by Denis Cherniy on 26.05.2021.
//

import UIKit

public final class RoundedButton: UIButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = bounds.height / 2
    }
}

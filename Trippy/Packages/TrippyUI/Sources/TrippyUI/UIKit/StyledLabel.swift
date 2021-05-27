//
//  File.swift
//  
//
//  Created by Denis Cherniy on 27.05.2021.
//

import UIKit

public final class StyledLabel: UILabel {
    
    public override var text: String? {
        didSet {
            updateAttributedText()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        updateAttributedText()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        updateAttributedText()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateAttributedText()
    }
    
    private func updateAttributedText() {
        guard let text = text else { return }
        
        let components = text.components(separatedBy: .newlines)
        
        guard components.count > 1,
              let firstLine = components.first else { return }
        
        let titleFont = UIFont.systemFont(ofSize: 30)
        
        let titleFontAttribute: [NSAttributedString.Key: Any] = [.font: titleFont]
        let firstLineRange = (text as NSString).range(of: firstLine)
        
        let subtitleFont = UIFont.systemFont(ofSize: 20)
        
        let attributedText = NSMutableAttributedString(string: text,
                                                       attributes: [.font: subtitleFont])
        attributedText.addAttributes(titleFontAttribute, range: firstLineRange)
        
        self.attributedText = attributedText
    }
}

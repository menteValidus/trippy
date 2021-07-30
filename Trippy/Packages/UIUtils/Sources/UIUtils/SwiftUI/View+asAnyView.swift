//
//  View+asAnyView.swift
//  
//
//  Created by Denis Cherniy on 28.07.2021.
//

import SwiftUI

public extension View {
    
    var asAnyView: AnyView {
        AnyView(self)
    }
}

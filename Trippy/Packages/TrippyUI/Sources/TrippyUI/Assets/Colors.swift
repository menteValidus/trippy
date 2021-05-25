//
//  Colors.swift
//  
//
//  Created by Denis Cherniy on 25.05.2021.
//

public extension Asset {
    enum Color {
        public static var primaryBackground = ColorAsset(name: "VioletBlue")
        public static let accent = ColorAsset(name: "SunYellow")
        
        public enum Text {
            public static let primary = ColorAsset(name: "White")
            public static let accent = ColorAsset(name: "SunYellow")
        }
        
        public enum Button {
            public static var background = ColorAsset(name: "SunYellow")
            public static var text = ColorAsset(name: "Indigo")
        }
    }
}

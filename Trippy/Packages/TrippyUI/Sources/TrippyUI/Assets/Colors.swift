//
//  Colors.swift
//  
//
//  Created by Denis Cherniy on 25.05.2021.
//

public extension Asset {
    
    enum Color {
        
        private enum BaseColor {
            static var violetBlue = ColorAsset(name: "VioletBlue")
            static var sunYellow = ColorAsset(name: "SunYellow")
            static var white = ColorAsset(name: "White")
            static var indigo = ColorAsset(name: "Indigo")
        }
        
        public static var primaryBackground = BaseColor.violetBlue
        public static let accent = BaseColor.sunYellow
        public static let separator = BaseColor.white
        
        public enum Text {
            public static let primary = BaseColor.white
            public static let accent = BaseColor.sunYellow
        }
        
        public enum Button {
            public static var background = BaseColor.sunYellow
            public static var text = BaseColor.indigo
        }
        
        public enum ConnectionLine {
            public static var background = BaseColor.indigo
        }
    }
}

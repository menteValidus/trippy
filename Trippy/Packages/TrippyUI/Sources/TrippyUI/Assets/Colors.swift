//
//  Colors.swift
//  
//
//  Created by Denis Cherniy on 25.05.2021.
//

public extension Asset {
    
    enum Color {
        
        private enum BaseColor {
            static let violetBlue = ColorAsset(name: "VioletBlue")
            static let sunYellow = ColorAsset(name: "SunYellow")
            static let white = ColorAsset(name: "White")
            static let indigo = ColorAsset(name: "Indigo")
        }
        
        public static let primaryBackground = BaseColor.violetBlue
        public static let accent = BaseColor.sunYellow
        public static let separator = BaseColor.white
        
        public enum Background {
//            public static let primary = BaseColor.violetBlue
            public static let secondary = BaseColor.sunYellow
        }
        
        public enum Text {
            public static let primary = BaseColor.white
            public static let accent = BaseColor.sunYellow
        }
        
        public enum Button {
            public static let background = BaseColor.sunYellow
            public static let text = BaseColor.indigo
        }
        
        public enum ConnectionLine {
            public static let background = BaseColor.indigo
        }
    }
}

//
//  Asset.swift
//  
//
//  Created by Denis Cherniy on 25.05.2021.
//

import SwiftUI
import UIKit

public enum Asset {}

public class ImageAsset {
    public let name: String

    internal init(name: String) {
        self.name = name
    }

    public var image: Image {
        guard let uiImage = uiImage else {
            return Image("this_image_name_does_not_exist", bundle: .module)
        }

        return Image(uiImage: uiImage)
    }

    public var uiImage: UIImage? {
        UIImage(named: name, in: .module, with: nil)
    }
}

public class ColorAsset {
    public let name: String

    internal init(name: String) {
        self.name = name
    }

    public var color: Color {
        guard let uiColor = uiColor else {
            return Color("this_color_name_does_not_exist", bundle: .module)
        }

        return Color(uiColor)
    }

    public var uiColor: UIColor? {
        UIColor(named: name, in: .module, compatibleWith: nil)
    }
}

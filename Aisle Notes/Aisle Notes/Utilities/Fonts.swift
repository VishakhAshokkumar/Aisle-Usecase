//
//  Fonts.swift
//  Aisle Notes
//
//  Created by Vishak on 08/07/25.
//

import UIKit

extension UIFont {
    
    static func interBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func interLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Light-BETA", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func gilroyRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Gilroy-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func gilroyBlack(size: CGFloat) -> UIFont {
        return UIFont(name: "Gilroy-Black", size: size) ?? UIFont.systemFont(ofSize: size, weight: .black)
    }
}

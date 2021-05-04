//
//  UIFont+Extensions.swift
//  HitPay
//
//  Created by DieuH on 19/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

struct HitPayFont {
    
    static let defaultSize: CGFloat = 10
    
    struct SFUIText {
        static let medium = "SFUIText-Medium"
        static let semiBold = "SFUIText-Semibold"
        static let bold = "SFUIText-Bold"
        static let regular = "SFUIText-Regular"
    }
}

extension UIFont {
    
    final class func sfUITextMedium(ofSize fontSize: CGFloat = HitPayFont.defaultSize) -> UIFont {
        return UIFont(name: HitPayFont.SFUIText.medium, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    final class func sfUITextSemiBold(ofSize fontSize: CGFloat = HitPayFont.defaultSize) -> UIFont {
        return UIFont(name: HitPayFont.SFUIText.medium, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    final class func sfUITextBold(ofSize fontSize: CGFloat = HitPayFont.defaultSize) -> UIFont {
        return UIFont(name: HitPayFont.SFUIText.medium, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    final class func sfUITextRegular(ofSize fontSize: CGFloat = HitPayFont.defaultSize) -> UIFont {
        return UIFont(name: HitPayFont.SFUIText.regular, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}

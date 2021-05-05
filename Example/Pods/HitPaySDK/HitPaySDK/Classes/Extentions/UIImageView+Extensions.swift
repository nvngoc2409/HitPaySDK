//
//  UIImageView+Extensions.swift
//  HitPay
//
//  Created by DieuH on 29/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

extension UIImageView {
    
    static func backgroundLogin() -> UIImageView {
        let imv = UIImageView(image: UIImage(named: ImageName.bgLogin))
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }
    
    static func hitPayLogoAndText() -> UIImageView {
        let imv = UIImageView(image: UIImage(named: ImageName.hitPayIconText))
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }
}



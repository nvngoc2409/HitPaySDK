//
//  BaseLabel.swift
//  HitPay
//
//  Created by DieuH on 28/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        font = .sfUITextMedium()
        textColor = .hitpayBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

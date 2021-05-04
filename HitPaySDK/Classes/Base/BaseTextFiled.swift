//
//  BaseTextFiled.swift
//  HitPay
//
//  Created by DieuH on 28/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

import UIKit

class ViewPhoneNumber: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lblNumber)
        addSubview(viewLine)
        
        NSLayoutConstraint.activate([
            lblNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
            lblNumber.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            viewLine.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            viewLine.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            viewLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            viewLine.widthAnchor.constraint(equalToConstant: HitPay.Layer.borderWidth)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let lblNumber: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "+65"
        lbl.font = .sfUITextRegular(ofSize: 17)
        return lbl
    }()
    
    let viewLine: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hitPayBorder
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
}

class BaseTextFiled: UITextField {
    
    static let heightDesign: CGFloat = 69 // Design heightTextFiled file sketch
    static let heightActual = heightDesign * HitPay.Ratio.deviceWidthToBaseDesignDeviceWidth
    static let heightRatio = heightDesign * HitPay.Ratio.deviceWidthToBaseDesignDeviceHeight

    
    enum TypeTextFied {
        case email
        case passWord
        case capitalizationWord
        case number
        case none
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = .hitpayBlue
        textAlignment = .center
        clearButtonMode = .whileEditing
        font = .sfUITextRegular(ofSize: 17)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = HitPay.Layer.cornerRadius
        layer.borderWidth = HitPay.Layer.borderWidth
        layer.borderColor = UIColor.hitPayBorder.cgColor
    }
    
    convenience init(type: TypeTextFied = .none, padding: UIEdgeInsets? = nil) {
        self.init()
        
        switch type {
        case .email:
            autocapitalizationType = .none
            keyboardType = .emailAddress
        case .capitalizationWord:
            autocapitalizationType = .words
        case .passWord:
            autocapitalizationType = .none
            isSecureTextEntry = true
        case .number:
            keyboardType = .numberPad
        default:
            return
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

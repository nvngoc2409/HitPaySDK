//
//  BaseButton.swift
//  HitPay
//
//  Created by DieuH on 28/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    enum BaseButtonStyle {
        case `none` // backgorund white, text black, no border
        case greenBG // background green, text white color, is bordered
        case hitpayBlueBG // background hitpay blue, text white color, is bordered
        case whiteBG //  background white, text hitpay blue, is bordered
        case basic
    }
    
    lazy var highlightView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.4)
        return v
    }()
    
    var isOpaqueHightLight = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = .sfUITextBold()
        titleLabel?.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard isOpaqueHightLight == true else {
                highlightView.isHidden = true
                return
            }
            if isHighlighted, !isDescendant(of: highlightView)  {
                highlightView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
                highlightView.layer.cornerRadius = layer.cornerRadius
                addSubview(highlightView)
            }
            highlightView.isHidden = !isHighlighted
        }
    }
    
    convenience  init(style: BaseButtonStyle,
                      text: String?,
                      font: UIFont? = .sfUITextBold(ofSize: 17)) {
        self.init()
        
        switch style {
        case .greenBG:
            backgroundColor = .hitPayGreen
            setTitleColor(.white, for: .normal)
            layer.cornerRadius = HitPay.Layer.cornerRadius
        case .hitpayBlueBG:
            backgroundColor = .hitpayBlue
            setTitleColor(.white, for: .normal)
            layer.cornerRadius = HitPay.Layer.cornerRadius
        case .whiteBG:
            backgroundColor = .white
            setTitleColor(.hitpayBlue, for: .normal)
            layer.borderColor = UIColor.hitPayBorder.cgColor
            layer.borderWidth = HitPay.Layer.borderWidth
            layer.cornerRadius = HitPay.Layer.cornerRadius
        case .none:
            setTitleColor(.black, for: .normal)
        case .basic:
            isOpaqueHightLight = false
            setTitleColor(.hitpayBlue, for: .normal)
        }
        
        if let font = font {
            titleLabel?.font = font
        }
        
        setTitle(text, for: .normal)
    }
}

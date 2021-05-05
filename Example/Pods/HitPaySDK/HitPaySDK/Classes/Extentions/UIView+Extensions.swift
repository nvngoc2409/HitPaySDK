//
//  UIView+Extensions.swift
//  HitPay
//
//  Created by DieuH on 19/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}

// MARK: - Auto layout code

extension UIView {
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    @IBInspectable var kBorderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var kBorderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var kCornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var kCircle: Bool {
        set {
            DispatchQueue.main.async {
                self.layer.cornerRadius = self.bounds.height/2
                self.layer.masksToBounds = true
            }
        }
        get {
            return layer.masksToBounds
        }
    }
    
    @IBInspectable var kShadowColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var kShadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var kShadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var kShadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var kShadowMasksToBounds: Bool {
        set {
            layer.masksToBounds = newValue
        }
        get {
            return layer.masksToBounds
        }
    }
}

extension UIView {
    func animateIn() {
        //        self.alpha = 0
        //        self.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (finished) in
            //            self.isHidden = finished
        }
    }
    
    func textDropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.masksToBounds = false
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        //        self.layer.masksToBounds = true
    }
    
}

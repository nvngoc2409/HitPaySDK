//
//  ViewUtil.swift
//  HitPay
//
//  Created by nitin muthyala on 11/9/16.
//  Copyright © 2016 Ezypayzy. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Spring
import AVFoundation

class ViewUtil {
    
    
    static func popAlertView(_ vc:UIViewController, title:String,message:String,option:String,handler:((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: option, style: UIAlertAction.Style.default, handler: handler))
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func getHUD(_ view:UIView) -> MBProgressHUD{
        
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        return loadingNotification
        
    }
    
    static func getAppRedColor() ->UIColor{
        return UIColor(red: 239/255.0, green: 110/255.0, blue: 91/255.0, alpha: 1.0)
    }
    
    static func getAppGreenColor() ->UIColor{
        return UIColor(red: 80/255.0, green: 227/255.0, blue: 194/255.0, alpha: 1.0)
    }
    
    static func getAppColor() ->UIColor{
        return UIColor(hex: "000036")
    }
    
    static func getAppOrange() ->UIColor{
        return UIColor(red: 255/255.0, green: 119/255.0, blue: 43/255.0, alpha: 1.0)
    }
    
    static func getAppPurple() ->UIColor{
        return UIColor(red: 156/255.0, green: 39/255.0, blue: 176/255.0, alpha: 1.0)
    }
    
    
    static func getAppColorGrad1() ->UIColor{
        return UIColor(red: 61/255.0, green: 78/255.0, blue: 129/255.0, alpha: 1.0)
    }
    
    static func getAppColorGrad2() ->UIColor{
        return UIColor(red: 87/255.0, green: 83/255.0, blue: 201/255.0, alpha: 1.0)
    }
    
    static func getAppColorGrad3() ->UIColor{
        return UIColor(red: 110/255.0, green: 127/255.0, blue: 243/255.0, alpha: 1.0)
    }
    
    static func playSound() {
        let systemSoundID: SystemSoundID = 1313
        AudioServicesPlaySystemSound (systemSoundID)
    }
    
    func attributedString(from string: String, boldRange: NSRange?) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize
        let boldattrs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let nonBoldAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: nonBoldAttribute)
        if let range = boldRange {
            attrStr.setAttributes(boldattrs, range: range)
        }
        return attrStr
    }
    
    static func triggerWhatsAppSurrort(_ vc:UIViewController){
        let msg = "Hello HitPay! I have a question"
        let urlWhats = "whatsapp://send?phone=+6598644718&text=\(msg)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                } else {
                    // Cannot open whatsapp
                    ViewUtil.popAlertView(vc, title: "WhatsApp Support", message: "Please WhatsApp us at +6598644718 if you have any questions", option: "Ok")
                }
            }
        }
    }
    
    
    static func isValidEmail(_ text:String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    static func validateNumber(field:UITextField,string:String) -> Bool{
    
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            
            let array = Array(field.text!)
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount += 1
                }
            }
            if decimalCount == 0 {
                if array.count > 2 {
                    return false
                }else{
                    return true
                }
            }else{
                // Check only 2 digits after decimal
                let numParts = field.text!.components(separatedBy: ".")
                if numParts.count > 1 {
                    let num = numParts[1]
                    if num.count > 1{
                        return false
                    }
                }
                
                if array.count > 5 {
                    return false
                }
            }
            
            
            return true
        case ".":
            let array = Array(field.text!)
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount += 1
                }
            }
            
            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = Array(string)
            if array.count == 0 {
                return true
            }
            return false
        }

    }
    
}




// MARK:- Extensions

private var handle: UInt8 = 0;

extension CAShapeLayer {
    public func drawCircleAtLocation(location: CGPoint, withRadius radius: CGFloat, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        let origin = CGPoint(x: location.x - radius, y: location.y - radius)
        path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
    }
}

extension UIBarButtonItem {
    
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func addBadge(number: Int, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.red, andFilled filled: Bool = true) {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        badgeLayer?.removeFromSuperlayer()
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let radius = CGFloat(5)
        let location = CGPoint(x: view.frame.width - (radius + offset.x) - 9, y: (radius + offset.y))
        badge.drawCircleAtLocation(location: location, withRadius: radius, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        
        // Save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func updateBadge(number: Int) {
        if let text = badgeLayer?.sublayers?.filter({ $0 is CATextLayer }).first as? CATextLayer {
            text.string = "\(number)"
        }
    }
    
    func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
    
}

extension UIView {
    public func applyGradient(){
        /*let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        let color1 = ViewUtil.getAppColorGrad1().cgColor
        let color2 = ViewUtil.getAppColorGrad2().cgColor
        let color3 = ViewUtil.getAppColorGrad3().cgColor
        gradient.colors = [color1, color2, color3]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        self.backgroundColor = .clear
        self.layer.insertSublayer(gradient, at: 0)*/
    }
    
    public func applyWhiteGradient(){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        let color1 = UIColor(hex: "FBFCDB").cgColor
        let color2 = UIColor(hex: "E9DEFA").cgColor
        gradient.colors = [color1, color2]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        self.backgroundColor = .clear
        self.layer.insertSublayer(gradient, at: 0)
    }
    
}



// MARK:- Navbar Util methods

extension UIViewController {
    public func makeNavbarClear(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize:18) , NSAttributedString.Key.foregroundColor : ViewUtil.getAppColor()]
    }
    
    public func makeNavbarBlue()
    {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor =  ViewUtil.getAppColor()
        self.navigationController?.view.backgroundColor =  ViewUtil.getAppColor()
        self.navigationController?.navigationBar.backgroundColor =   ViewUtil.getAppColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
       // self.navigationController?.navigationBar.titleTextAttributes =  [NSFontAttributeName: UIFont.systemFont(ofSize:18, weight: UIFontWeightSemibold) , NSForegroundColorAttributeName : UIColor.white]
    }
    
    public func makeNavbarGradient(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.navigationController!.navigationBar.frame.width, height: self.navigationController!.navigationBar.frame.height + 20)
        
        let color1 = ViewUtil.getAppColorGrad1().cgColor
        let color2 = ViewUtil.getAppColorGrad2().cgColor
        let color3 = ViewUtil.getAppColorGrad3().cgColor
        gradient.colors = [color1, color2, color3]
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        let gradImage = getImageFromGradient(layer: gradient)
        
        self.navigationController?.navigationBar.setBackgroundImage(gradImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = ViewUtil.getAppColor()
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18) , NSAttributedString.Key.foregroundColor : ViewUtil.getAppColor()]
        
    }
    
    func getImageFromGradient(layer:CAGradientLayer) ->UIImage?{
        UIGraphicsBeginImageContext(layer.frame.size)
        if UIGraphicsGetCurrentContext() != nil {
            layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
}


extension UILabel {
    
    func boldRange(_ range: Range<String.Index>) {
        if let text = self.attributedText {
            let attr = NSMutableAttributedString(attributedString: text)
            let start = text.string.distance(from: text.string.startIndex, to: range.lowerBound)
            let length = text.string.distance(from: range.lowerBound, to: range.upperBound)
            attr.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: self.font.pointSize)], range: NSMakeRange(start, length))
            self.attributedText = attr
        }
    }
    
    func boldSubstring(_ substr: String) {
        if let text = self.attributedText {
            var range = text.string.range(of: substr)
            let attr = NSMutableAttributedString(attributedString: text)
            while range != nil {
                let start = text.string.distance(from: text.string.startIndex, to: range!.lowerBound)
                let length = text.string.distance(from: range!.lowerBound, to: range!.upperBound)
                var nsRange = NSMakeRange(start, length)
                let font = attr.attribute(NSAttributedString.Key.font, at: start, effectiveRange: &nsRange) as! UIFont
                if !font.fontDescriptor.symbolicTraits.contains(.traitBold) {
                    break
                }
                range = text.string.range(of: substr, options: NSString.CompareOptions.literal, range: range!.upperBound..<text.string.endIndex, locale: nil)
            }
            if let r = range {
                boldRange(r)
            }
        }
    }
}




// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

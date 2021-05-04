//
//  Extensions.swift
//  HitPay
//
//  Created by nitin muthyala on 2/5/18.
//  Copyright © 2018 Ezypayzy. All rights reserved.
//

import UIKit
import Stripe

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting(maxDecimals:Int) -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "EN")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxDecimals
        formatter.minimumFractionDigits = maxDecimals
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        let devideBy = pow(10.0, Double(maxDecimals))
        number = NSNumber(value: (double / devideBy))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}

extension URL {
    
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func dropShadow(){
        layer.shadowOpacity = 0.20
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
    }
}

extension UIColor {
    
    final class var hitpayBlue: UIColor {
        return UIColor(hex:"000036")
    }
    
    final class var hitPayTextGray: UIColor {
        return UIColor(hex: "9B9B9B")
    }
    
    final class var hitPayBgGray: UIColor {
        return UIColor(hex: "EFEFF4")
    }
    
    final class var hitPayBorder: UIColor {
        return UIColor(hex: "979797")
    }
    
    final class var hitPayGreen: UIColor {
        return UIColor(hex: "50E3C2")
    }
    
    final class var hitPayBgPopUp: UIColor {
        return UIColor(white: 0, alpha: 0.6)
    }
}

extension CALayer {
    
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

func HitPayDebugPrint(_ value: Any...,
                fileName: String = #file,
                functionName: String = #function,
                lineNumber: Int = #line,
                columnNumber: Int = #column) {
    #if DEBUG
    let className = fileName.components(separatedBy: "/").last ?? ""
    print(
        """
        -->Class Name:  \(className)
            --Function: \(functionName)
                --Line: \(lineNumber)[\(columnNumber)]
                    --Log: \(value)
        """)
    #endif
}


extension UIViewController {

    private func canPresentViewController() -> Bool {
        return isViewLoaded &&
            view.window != nil &&
            presentedViewController == nil &&
            !isBeingDismissed &&
            !isMovingToParent
    }

    /**
     Requests a value by presenting an action sheet with the given options.
     If "Cancel" is selected, `handler` will be called with `currentValue`.
     */
    func presentValuePicker<T>(title: String?, options: [T], from sourceView: UIView?, handler: @escaping (T?) -> Void) where T: CustomStringConvertible {
        guard canPresentViewController() else { return }

        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for opt in options {
            let action = UIAlertAction(title: opt.description, style: .default, handler: { _ in
                handler(opt)
            })
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            handler(nil)
        })
        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView?.bounds ?? .zero
        present(alertController, animated: true, completion: nil)
    }

    /**
     Requests a value by presenting an alert view with a text field.
     `handler` may be called with nil if the entered text can't converted back
     to the original type. If "Cancel" is selected, `handler` will be called
     with `currentValue`.
     TODO: try to remove currentValue in swift 4
     */
    func presentValueInputH<T>(title: String?, currentValue: T, handler: @escaping (T?) -> Void) where T: LosslessStringConvertible {
        guard canPresentViewController() else { return }

        // need an instance of T to check its type
        let value = T("0")
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            if value is Int || value is UInt {
                textField.keyboardType = .numberPad
            } else if value is Float || value is Double || value is CGFloat {
                textField.keyboardType = .decimalPad
            }
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alertController.textFields?.first?.text else {
                handler(nil)
                return
            }
            handler(T(text))
        }
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            handler(nil)
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    /**
     Presents the given error using an alert view.
     */
    func presentAlert(error: Error) {
        presentAlert(title: "Error", message: error.localizedDescription)
    }

    /**
     Presents the given error using an alert view, with a handler.
     */
    func presentAlert(error: Error, handler: @escaping (Bool) -> Void) {
        presentAlert(title: "Error", message: error.localizedDescription, handler: handler)
    }

    /**
     Presents the given title and message using an alert view.
     */
    func presentAlert(title: String, message: String) {
        guard canPresentViewController() else { return }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    /**
     Presents the given title and message using an alert view with OK and cancel buttons.
     */
    func presentAlert(title: String, message: String, okButtonTitle: String? = nil, handler: @escaping (Bool) -> Void) {
        guard canPresentViewController() else { return }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle ?? "OK", style: .default) { _ in
            handler(true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            handler(false)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}

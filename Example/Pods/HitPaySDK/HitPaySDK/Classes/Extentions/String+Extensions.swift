//
//  String+Extensions.swift
//  HitPay
//
//  Created by DieuH on 21/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

extension String {
    
    func convertconvertRFC3339ToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter.date(from: self)
    }
    
    func convertRFC3339DateTimeString() -> String? {
        guard let date = convertconvertRFC3339ToDate() else {
            return self
        }
        var userVisibleDateTimeString: String
        let userVisibleDateFormatter = DateFormatter()
        userVisibleDateFormatter.timeZone = TimeZone(identifier: "GMT+8")
        userVisibleDateFormatter.dateStyle = .medium
        userVisibleDateFormatter.timeStyle = .short
        userVisibleDateTimeString = userVisibleDateFormatter.string(from: date)
        return userVisibleDateTimeString
    }
    // MARK: - height text
    
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        
        return boundingBox.width
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let startPos = self.distance(from: self.startIndex, to: range.lowerBound)
        let endPos = self.distance(from: self.startIndex, to: range.upperBound)
        return NSMakeRange(startPos, endPos - startPos)
    }
    
    func isValidatePassWord() -> Bool {
        //Password must contain a minimum of 8 characters,
        // containing 1 upper case, 1 lower case, 1 number and 1 special character
        let regex = NSRegularExpression("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[#$^+=!*()@%&]).{8,}")
        return regex.matches(self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = NSRegularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailRegEx.matches(self)
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func jsonStringtoDictionary() -> [String: Any]? {
        if let data = data(using: .utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }
        return nil
    }
}

extension Double {
    
    func formatToStringDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd MMM yyyy 'at' hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let date = Date(timeIntervalSince1970: self)
        return formatter.string(from: date)
    }
    
    func toUInt() -> UInt? {
        if self >= Double(UInt.min) && self < Double(UInt.max) {
            return UInt(self)
        } else {
            return nil
        }
    }
}

extension NSRegularExpression {
    
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}



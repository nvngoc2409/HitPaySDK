//
//  Currency.swift
//  HitPay
//
//  Created by nitin muthyala on 30/7/18.
//  Copyright © 2018 Ezypayzy. All rights reserved.
//

import Foundation

class Currency: NSObject, NSCoding {
    let code: String
    let country : String
    let minimum : Int
    let isZeroDecimal : Bool
    
    init(code:String,country:String,minimum:Int = 1,isZeroDecimal: Bool = false) {
        self.code = code
        self.country = country
        self.minimum = minimum
        self.isZeroDecimal = isZeroDecimal
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.code, forKey: "code")
        aCoder.encode(self.country, forKey: "country")
        aCoder.encode(self.minimum, forKey: "minimum")
        aCoder.encode(self.isZeroDecimal, forKey: "isZeroDecimal")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.code = aDecoder.decodeObject(forKey: "code") as! String
        self.country = aDecoder.decodeObject(forKey: "country") as! String
        self.minimum = Int(aDecoder.decodeInteger(forKey: "minimum"))
        self.isZeroDecimal = aDecoder.decodeBool(forKey: "isZeroDecimal")
    }
}

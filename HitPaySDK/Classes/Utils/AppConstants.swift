//
//  AppConstants.swift
//  HitPay
//
//  Created by nitin muthyala on 9/9/16.
//  Copyright © 2016 Ezypayzy. All rights reserved.
//

import Foundation

class AppConstants {
    
    /**
     *  Stripe Keys
     */
    // Stripe live = pk_live_hmprpv25fESJncm2757h73dx
    // Stripe test = pk_test_O0VHVlWJ3JIvEnXl0gCT44XH
    // India live pk_live_X5GTrGuk94Y81ykqgnf8OQYc
    // India test pk_test_D4SxbJldGKHK2smahc0zMIIf
    
    // Staging
    static let BASE_URL: String = {
        return AppManager.getString(AppConstants.PREF_BASE_URL) ?? AppConstants.BASE_URL_MAIN
    }()
    
   
/*
    #if DEBUG
    //static let BASE_URL_MAIN = "https://pos-staging.hit-pay.com/api"
    //static let BASE_URL_IN = "https://pos-staging.in.hit-pay.com/api"
    static let BASE_URL_MAIN = "https://api.staging.hit-pay.com/v1"
    static let BASE_URL_IN = "https://api.staging.hit-pay.com/v1"
//    static let BASE_URL_MAIN = "https://api.hit-pay.com/v1"
//    static let BASE_URL_IN = "https://api.hit-pay.com/v1"
    #else
    //    static let BASE_URL_MAIN = "https://pos.hit-pay.com/api"
    //    static let BASE_URL_IN = "https://pos.in.hit-pay.com/api"
        static let BASE_URL_MAIN = "https://api.staging.hit-pay.com/v1"
        static let BASE_URL_IN = "https://api.staging.hit-pay.com/v1"
//    static let BASE_URL_MAIN = "https://api.hit-pay.com/v1"
//    static let BASE_URL_IN = "https://api.hit-pay.com/v1"
    #endif
    // static let BASE_URL_MAIN = "https://pos-staging.hit-pay.com/api"
    // static let BASE_URL_IN = "https://pos-staging.in.hit-pay.com/api"
 */
    
    //Config Staging
    static var isStaging = false
    
    static let BASE_URL_MAIN: String = {
        if isStaging {
            return "https://api.staging.hit-pay.com/v1"
        }
        return "https://api.hit-pay.com/v1"
    }()
    
    static let BASE_URL_IN: String = {
        if isStaging {
            return "https://api.staging.hit-pay.com/v1"
        }
        return "https://api.hit-pay.com/v1"
    }()
    
    static let STRIPE_PUBLISHABLE_KEY: String = {
        if isStaging {
            return "pk_test_60FcfyimVC928dd7hs4dmUTR"
        }
        return "pk_live_hmprpv25fESJncm2757h73dx"
/*        if AppManager.isIndia() {
            #if DEBUG
            return "pk_test_O0VHVlWJ3JIvEnXl0gCT44XH"
            #else
            return "pk_test_D4SxbJldGKHK2smahc0zMIIf"
            //return "pk_live_X5GTrGuk94Y81ykqgnf8OQYc"
            #endif
            //return "pk_live_X5GTrGuk94Y81ykqgnf8OQYc"
        } else {
            #if DEBUG
            return "pk_test_O0VHVlWJ3JIvEnXl0gCT44XH"
            #else
            return "pk_test_O0VHVlWJ3JIvEnXl0gCT44XH"
            //return "pk_live_hmprpv25fESJncm2757h73dx"
            #endif
        } */
    }()
    
    // AppStore ID
    
    static let APP_STORE_ID_URL_SCHEME = "itms-apps://itunes.apple.com/app/apple-store/id1153486894?mt=8"
    static let APP_STORE_LINK = "https://itunes.apple.com/app/apple-store/id1153486894?mt=8"
    
    static let termURL = "https://www.hitpayapp.com/privacy-and-terms"
    
    /**
     *  User Defaults
     */
//    static let CURRENCY_DEFAULT_USER = "CURRENCY_\(AppManager.getString("userID") ?? "")"
    static let EXTRA_PAY_REQUEST_KEY = "EXTRA_PAY_REQUEST" 
    static let EXTRA_PAY = "EXTRA_PAY" 
    static let EXTRA_REQUEST = "EXTRA_REQUEST" 
    static let EXTRA_SIGN_UP_STATE = "EXTRA_SIGN_UP_STATE"
    static let SELECTED_CURRENCY = "Selected_Crrency"
    
    static let SHARED_PREFERENCES_FILE = "SHARED_PREFERENCES_FILE" 
    static let PREF_USER_ID = "PREF_USER_ID " 
    static let PREF_USER_NAME = "PREF_USER_NAME"
    static let PREF_STORE_URL = "PREF_STORE_URL"
    static let PREF_IS_MERCHANT_ACCOUNT = "PREF_IS_MERCHANT_ACCOUNT"
    static let PREF_MERCHANT_ACCEPTS_CARDS = "PREF_MERCHANT_ACCEPTS_CARDS"
    static let PREF_USER_MOBILE_NO = "PREF_USER_MOBILE_NO" 
    static let PREF_USER_EMAIL = "PREF_USER_EMAIL"
    static let PREF_REF_CODE = "PREF_REF_CODE"
    static let PREF_REF_MESSAGE = "PREF_REF_MESSAGE"
    static let PREF_LOGO_URL = "PREF_LOGO_URL"
    static let PREF_SUBSCRIPTION_SETTINGS = "PREF_SUBSCRIPTION_SETTINGS"
    static let PREF_DISPLAY_NAME = "PREF_DISPLAY_NAME"
    static let PREF_BUSINESS_CATEGORY = "PREF_BUSINESS_CATEGORY"
    static let PREF_PENDING_TRANSACTIONS = "PREF_PENDING_TRANSACTIONS"
    static let PREF_IS_CART_ENABLED = "PREF_IS_CART_ENABLED"
    static let PREF_DEFAULT_CURRENCY = "PREF_DEFAULT_CURRENCY"
    static let PREF_MERCH_HOME = "PREF_MERCH_HOME"
    static let PREF_PAYNOW_DATA = "PREF_PAYNOW_DATA"
    
    static let PREF_TRANSFER_LIMIT = "PREF_TRANSFER_LIMIT" 
    static let PREF_PAYMENT_REMINDER = "PREF_PAYMENT_REMINDER" 
    static let PREF_PENDING_REQ_COUNT = "PREF_PENDING_REQ_COUNT" 
    static let PREF_WALLET_BALANCE = "PREF_WALLET_BALANCE"
    static let PREF_GROSS_COLLECTION = "PREF_GROSS_COLLECTION"
    static let PREF_LOW_BAL_ALERT = "PREF_LOW_BAL_ALERT" 
    static let PREF_USER_TOKEN = "PREF_USER_TOKEN"
    static let PREF_USER_REFRESH_TOKEN = "PREF_USER_REFRESH_TOKEN"
    static let PREF_USER_DEVICE_TOKEN = "PREF_USER_DEVICE_TOKEN" 
    static let PREF_MOBILE_VERIFIED = "PREF_MOBILE_VERIFIED" 
    static let PREF_EMAIL_VERIFIED = "PREF_EMAIL_VERIFIED" 
    static let PREF_PROFILE_PIC = "PREF_PROFILE_PIC"
    static let PREF_TOUCH_ID_OFF = "PREF_TOUCH_ID_OFF"
    static let PREF_CUSTOMER_ID = "PREF_CUSTOMER_ID"
    static let PREF_REQ_OPERATION_MESSAGE = "PREF_REQ_OPERATION_MESSAGE"
    static let PREF_PAY_MODE_CARD = "PREF_PAY_MODE_CARD"
    static let PREF_PAY_MODE_ALI = "PREF_PAY_MODE_ALI"
    static let PREF_PAY_MODE_CASH = "PREF_PAY_MODE_CASH"
    static let PREF_PAY_MODE_PAYNOW = "PREF_PAY_MODE_PAYNOW"
    static let PREF_PAY_MODE_WECHAT = "PREF_PAY_MODE_WECHAT"
    static let PREF_LAST_PAY_MODE = "PREF_LAST_PAY_MODE"
    static let PREF_REFERRAL_URL = "PREF_REFERRAL_URL"
    static let PREF_BASE_URL = "PREF_BASE_URL"
    static let PREF_USER_STRIPE_ID = "PREF_USER_STRIPE_ID"
    static let PREF_EMAIL_LOGIN_ENABLED = "PREF_EMAIL_LOGIN_ENABLED"
    
    static let KEYCHIN_USERNAME = "KEYCHIN_USERNAME"
    static let KEYCHIN_PASSWORD = "KEYCHIN_PASSWORD"
    static let KEYCHIN_ACESS_TOKEN = "KEYCHIN_ACESS_TOKEN"
    static let KEYCHIN_REFRESH_TOKEN = "KEYCHIN_REFRESH_TOKEN"
    static let KEYCHIN_AUTHENTICATION_TOKEN = "KEYCHIN_AUTHENTICATION_TOKEN"
    
    static let PREF_ACC_NAME = "PREF_ACC_NAME" 
    static let PREF_ACC_NO = "PREF_ACC_NO" 
    static let PREF_ACC_BANK = "PREF_ACC_BANK" 
    static let PREF_ACC_BANK_ID = "PREF_ACC_BANK_ID"
    static let TUTORIAL_SEEN = "TUTORIAL_SEEN"
    
    static let SIGN_UP_NO_USER = 1
    static let SIGN_UP_NO_MOBILE = 2
    static let SIGN_UP_NO_EMAIL = 3
    static let SIGN_UP_OK = 4
    
    static let REQUESTED = "Requested" 
    static let COMPLETED = "Completed"
    
    static let HITPAY_USER_PIC = "/HitPayProfile.png"
    static let APP_GROUP = "group.com.hit-pay-solutions"
    
    static let GENERAL_ERROR = "Error while processing please try again"
    static let INTERNET_ERROR = "Internet not available, Cross check your internet connectivity and try again"
    static let TOKEN_HIBERNATE  = "token-hibernating"
    static let TOKEN_INVALID  = "invalid-token"
    static let IS_FORCE_UPDATE = "force_update"
    
    static let ENABLE_FABRIC = true
    
    static let PAY_BY_ME = "PAY_BY_ME"
    static let REFUNDED_TO_ME = "REFUNDED_TO_ME"
    static let REFUNDED_BY_ME = "REFUNDED_BY_ME"
    static let REQUESTED_MY_ME = "REQUESTED_MY_ME"
    static let WITHDRAW_MY_ME = "WITHDRAW_MY_ME"
    static let TOPUP_MY_ME = "TOPUP_MY_ME"
    static let PROMO_MY_ME = "PROMO_MY_ME"
    static let REFF_MY_ME = "REFF_MY_ME"
    static let CASH_BACK = "CASH_BACK"
    static let FREE_CASH = "FREE_CASH"
    static let HITPAY_CHARGE = "HITPAY_CHARGE"
    static let CARD_PAYMENT = "CARD_PAYMENT"
    static let LINK_PAYMENT = "LINK_PAYMENT"
    static let ALI_PAY_PAYMENT  = "ALI_PAY_PAYMENT"
    
    static let KEYBOARD_INSTALLED = "KEYBOARD_INSTALLED"
    static let DONT_SHOW_KEYBOARD_TUTORIAL = "DONT_SHOW_KEYBOARD_TUTORIAL"
    /**
     *  Labels
     */
    static let OB_HEADING_1 = "HitPay POS allows you to collect business payments on the go, wherever your customers are"
    static let OB_HEADING_2 = "All Major Payment Methods Supported"
    static let OB_HEADING_3 = "No Recurring Fees. Only Pay Per Transaction"
    static let OB_HEADING_4 = "All Payments Processed using Best in Class Payment Security Standards"
    
    static let OB_BODY_1 = "Swipe to learn more"
    static let OB_BODY_2 = "Sign up as a HitPay merchant and accept payments from business customers within minutes"
    static let OB_BODY_3 = "Sign up as HitPay customer to send and request payments from your mates  \n\nHitPay e-wallet works seemlessly with any Singapore Bank Account with PayNow and FAST bank transfers top ups"
    static let OB_BODY_4 = "We value customer data and do not share your data with any third party\n\nHitpay uses best in class payments and security architecture with support for PCI and DSS gateway and biometric authentication"
    static let refundTooLate = "The recipient of this transfer does not have sufficient funds in their Stripe balance to reverse this amount."
    static let refundTooLateMod = "The settlement for this transaction has been completed"
    
    static let OB_IMAGE_1 = "OB_IMAGE_1"
    static let OB_IMAGE_2 = "OB_IMAGE_2"
    static let OB_IMAGE_3 = "OB_IMAGE_3"
    static let OB_IMAGE_4 = "OB_IMAGE_4"
    
    //JSON Formats for QR Code
    
    static let QRCODE_MERCHANT_USER_TYPE = "MERCHANT"
    static let QRCODE_NORMAL_USER_TYPE = "NORMAL"
    static let QRCODE_PROMO_USER_TYPE = "PROMOTION"
    
    static let QR_CODE_VERSION = "2"
    static let VERSION_KEY = "version"
    static let USER_TYPE_KEY = "UserType"
    static let NAME_KEY = "Name"
    static let NUMBER_KEY = "Number"
    static let AMOUNT_KEY = "Amount"
    static let ACCEPTS_CARDS_KEY = "AcceptsCards"
    static let PROMO_ID_KEY = "PromoID"
    static let PROMO_TITLE_KEY = "Title"
    static let PROMO_MESSAGE_KEY = "Message"
    static let ISSHOWED_RATE = "isShowedRate"

    // MARK: - Message popup updated login
    
    //static let USER_ID_FORMAT = "{\"version\":\"3\",\"UserType\":\"PROMOTION\",\"PromoID\":\"URBAN_VENTURES\",\"Title\":\"Free Beer at Urban Ventures\",\"Message\":\"Get your free beer by showing this promo at the redemption counter\"}"
    
    static let USER_ID_FORMAT = "{\"version\":\"%@\",\"UserType\":\"%@\",\"Name\":\"%@\",\"Number\":\"%@\",\"Amount\":\"%@\",\"AcceptsCards\":%d}"
    static let PROMO_FORMAT = "{\"version\":\"%@\",\"UserType\":\"%@\",\"PromoID\":\"%@\",\"Title\":\"%@\",\"Message\":\"%@\"}"
    static let SERVER_VERSION_KEY = "serverVersion"
    static let currList:[Currency] = [Currency(code: "SGD", country: "Singapore"),
                                      Currency(code: "IND", country: "India"),
                                      Currency(code: "AED", country: "United Arab Emirates Dirham"),
                                      Currency(code: "AUD", country: "Australian Dollar"),
                                      Currency(code: "BRL", country: "Brazilian Real"),
                                      Currency(code: "CHF", country: "Swiss Franc"),
                                      Currency(code: "CNY", country: "Chinese Yuan Renminbi"),
                                      Currency(code: "DKK", country: "Danish Krone"),
                                      Currency(code: "EUR", country: "Euro"),
                                      Currency(code: "GBP", country: "Pound Sterling"),
                                      Currency(code: "HKD", country: "Hong Kong Dollar"),
                                      Currency(code: "IDR", country: "Indonesian rupiah"),
                                      Currency(code: "JPY", country: "Japanese Yen"),
                                      Currency(code: "KRW", country: "South Korean Won"),
                                      Currency(code: "MXN", country: "Mexican Peso"),
                                      Currency(code: "MYR", country: "Malaysian Ringgit"),
                                      Currency(code: "NOK", country: "Norwegian Krone"),
                                      Currency(code: "SEK", country: "Swedish Krona"),
                                      Currency(code: "THB", country: "Thai Babt"),
                                      Currency(code: "TRY", country: "Turkish Lira"),
                                      Currency(code: "TWD", country: "New Taiwan Dollar"),
                                      Currency(code: "USD", country: "United States Dollar"),
                                      Currency(code: "VND", country: "Vietnamese Dong"),
                                      Currency(code: "ZAR", country: "South African Rand")
    ]
    static let countryList = ["AUSTRALIA",
                              "AUSTRIA",
                              "BELGIUM",
                              "CANADA",
                              "DENMARK",
                              "FINLAND",
                              "FRANCE",
                              "GERMANY",
                              "HONG_KONG_CHINA",
                              "INDIA",
                              "IRELAND",
                              "ITALY",
                              "JAPAN",
                              "LUXEMBOURG",
                              "NETHERLANDS",
                              "NEW_ZEALAND",
                              "NORWAY",
                              "PORTUGAL",
                              "SINGAPORE",
                              "SPAIN",
                              "SWEDEN",
                              "SWITZERLAND",
                              "UNITED_KINGDOM",
                              "UNITED_STATES"]
}

enum PaymentType {
    case CARD
    case ALIPAY
    case CASH
    case PAYNOW
    case CARDREADER
    case WECHAT
    case LINK
    
    func stringValue() -> String {
        switch self {
        case .CASH:
            return "CASH"
        case .WECHAT:
            return "WeChat Pay"
        case .PAYNOW:
            return "PayNow"
        case .ALIPAY:
            return "AliPay"
        case .CARDREADER:
            return "Card Reader"
        default:
            return "CARD"
        }
    }
}

class DataStore {
    private init() { }
    static let shared = DataStore()
    var baseUrl: String?
}

enum ImageName {
    static let cardboardBox =  "cardboard-box"
    static let backGroundButton = "bg_button"
    static let backButton = "back-1"
    static let backButtonTemplate = "back_template"
    static let hitPayIconText = "HitPayIconText"
    static let bgLogin = "bgLogin"
    static let btnCloseHitPayBlueColor = "btnClose_HitPayBlue"
    static let btnCloseWhite = "btnClose"
    static let popupUpdate = "popupUpdate"
    static let success = "ic_success"
    static let eye = "eye"
    static let check = "check"
    static let uncheck = "uncheck"
}

enum HitPay {
    
    static let maxValueStep: Double = 999999
    
    enum AlertMessage {
        static let passWordValidate = "Password must contain a minimum of 8 characters, containing 1 upper case, 1 lower case, 1number and 1 special character"
        static let fillAllField = "Please make sure all fields are filled"
        static let passwordNotMatch = "Confirm password does not match"
        static let displayNameRequired = "The display name field is required."
        static let companyNameRequired = "The name field is required."
        static let emailRequired = "The email field is required."
        static let emailNotAvalidate = "The email must be a valid email address."
        static let passWordRequred = "The password field is required."
        static let enterYourEmail = "The email field is required."
        static let selectCountry = "Please select your country"
    }
    
    enum Layer {
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 0.75
        static let alpha: CGFloat = 0.4
    }
    
    enum Margin {
        static let `default`: CGFloat = UIScreen.main.bounds.width / 7.5
        static let verySmall: CGFloat = 2
        static let small: CGFloat = 5
        static let xxSmall: CGFloat = 8
        static let medium: CGFloat = 16
        static let xxMedium: CGFloat = 32
        static let large: CGFloat = 40
        static let xxlarge: CGFloat = 50
    }
    
    enum Size {
        static let baseDesignWidthScreen: CGFloat = 414
        static let baseDesignHeightScreen: CGFloat = 896
        
        enum Height {
            static let small: CGFloat = 44
            static let medium: CGFloat = 55
            static let large: CGFloat = 70
        }
        
        enum Width {
            static let `default`: CGFloat = UIScreen.main.bounds.width / 2
            static let small: CGFloat = 44
            static let medium: CGFloat = 100
            static let large: CGFloat = 200
        }
    }
    
    enum Symbols {
        static let question = "􀍰"
        static let eye = "􀋭"
        static let eyeFill = "\u{F070}"
    }
    
    enum Device {
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
    }
    
    enum Ratio {
        static let deviceWidthToBaseDesignDeviceWidth = Device.width / Size.baseDesignWidthScreen
        static let deviceWidthToBaseDesignDeviceHeight = Device.height / Size.baseDesignHeightScreen
    }
    
}


//
//  AppManager.swift
//  HitPay
//
//  Created by nitin muthyala on 9/9/16.
//  Copyright © 2016 Ezypayzy. All rights reserved.
//

import Foundation
import LocalAuthentication
import KeychainSwift
import Alamofire
import SwiftyJSON
import StoreKit

#if MAIN_APP
    import Firebase
    import FirebaseInstanceID

#endif

class AppManager
{
    static func checkSighUpStatus() -> Bool {
        let token = getFromKeychain(AppConstants.KEYCHIN_ACESS_TOKEN)
        //let tokenAuthenti = getFromKeychain(AppConstants.KEYCHIN_AUTHENTICATION_TOKEN)
        
        if let token = token, !token.isEmpty {
            return true
        }

        if self.getString(AppConstants.PREF_USER_TOKEN) != nil {
            return true
        }
        
//        if let tokenAuthenti = tokenAuthenti, !tokenAuthenti.isEmpty {
//            return true
//        }
        
        return false
    }
    
    // Using UserDefault
    static func getToken() -> String?{
        return self.getString(AppConstants.PREF_USER_TOKEN)
    }
    
    static func setToKeychain(_ key:String,value:String){
        let keychain = KeychainSwift()
        keychain.accessGroup = AppConstants.APP_GROUP
        keychain.set(value, forKey:key)
    }
    
    static func getFromKeychain(_ key:String) -> String?
    {
        let keychain = KeychainSwift()
        keychain.accessGroup = AppConstants.APP_GROUP
        return keychain.get(key)
    }
    
    static func removeAllKeychain() {
        let keychain = KeychainSwift()
        keychain.clear()
    }
    
    static func getString(_ key:String) -> String? {
        guard let userDefault = UserDefaults.init(suiteName: AppConstants.APP_GROUP) else {
            return nil
        }
        return userDefault.string(forKey: key)
    }
    
    static func setString(_ key:String,value:String?){
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.set(value, forKey: key)
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.synchronize()
    }
    
    static func deleteDefaultString(_ key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func setBool(_ key:String,value:Bool){
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.set(value, forKey: key)
    }
    
    static func getBool(_ key:String)->Bool
    {
        if UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.object(forKey: key) == nil {
            return false
        }
        return UserDefaults.init(suiteName:AppConstants.APP_GROUP)!.bool(forKey: key)
    }
    
    static func setInt(_ key:String,value:Int){
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.set(value, forKey: key)
    }
    
    static func getInt(_ key:String)->Int{
        if UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.object(forKey: key) == nil {
            return -1
        }
        return UserDefaults.init(suiteName:AppConstants.APP_GROUP)!.integer(forKey: key)
    }
    
    static func setDouble(_ key:String,value:Double){
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.set(value, forKey: key)
    }
    
    static func getDouble(_ key:String)->Double{
        if UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.object(forKey: key) == nil {
            return -1
        }
        return UserDefaults.init(suiteName:AppConstants.APP_GROUP)!.double(forKey: key)
    }
    
    static func setDictionary(_ key:String,value:Dictionary<String, Any>)
    {
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.set(value, forKey: key)
    }
    
    static func getDictionary(_ key:String)->Dictionary<String, Any>?
    {
        if UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.object(forKey: key) == nil
        {
            return nil        }
        
        return UserDefaults.init(suiteName:AppConstants.APP_GROUP)!.object(forKey: key) as? Dictionary<String, Any>
    }
    
    static func deleteString(_ key:String){
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.removeObject(forKey: key)
        UserDefaults.init(suiteName:AppConstants.APP_GROUP)?.synchronize()
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
       }
    
    static func getDeviceTokenString() -> String
    {
        #if MAIN_APP
            if let deviceToken = AppManager.getString(AppConstants.PREF_USER_DEVICE_TOKEN){
                
                return deviceToken
            }else{
                // Try getting the token again
                if let token = FIRInstanceID.instanceID().token(){
                    return token
                }
            }
            return ""
        #else
            if let deviceToken = AppManager.getString(AppConstants.PREF_USER_DEVICE_TOKEN){
                
                return deviceToken
            }
            return ""
        #endif
    }
    
    static func requestRating()
    {
        if #available( iOS 10.3,*)
        {
            SKStoreReviewController.requestReview()
        }
    }
    
    static func isIndia() -> Bool {
        let baseUrl = DataStore.shared.baseUrl ?? AppConstants.BASE_URL
        return baseUrl == AppConstants.BASE_URL_IN
    }
    
    static func isTouchIdAvailable() -> Bool{
        let authenticationContext = LAContext()
        var error:NSError?
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            HitPayDebugPrint("no touch id ")
            return false
        }
        
        if getInt(AppConstants.PREF_TOUCH_ID_OFF) == 1 {
            HitPayDebugPrint("no touch off ")
            return false
        }
        
        if getFromKeychain(AppConstants.KEYCHIN_PASSWORD) == nil {
            HitPayDebugPrint("no password ")
            return false
        }
        
        if getString(AppConstants.PREF_USER_TOKEN) == nil {
            HitPayDebugPrint("no token ")
            return false
        }
        
        if getString(AppConstants.KEYCHIN_USERNAME) == nil {
            HitPayDebugPrint("no username ")
            return false
        }
        
        return true
        
    }
    
    static func canShowLockSreen() -> Bool{
        
        if getString(AppConstants.PREF_USER_TOKEN) == nil {
            return false
        }
        
        if getString(AppConstants.KEYCHIN_USERNAME) == nil {
            return false
        }
        
        return true

    }
    
    static func removeAllData()
    {
        if let defaults = UserDefaults.init(suiteName:AppConstants.APP_GROUP)
        {
            for key in defaults.dictionaryRepresentation().keys
            {
                if key != AppConstants.PREF_PROFILE_PIC || key != AppConstants.SERVER_VERSION_KEY
                {
                    defaults.removeObject(forKey: key)
                }
            }
            defaults.synchronize()
        }
        AppManager.deleteString(AppConstants.KEYCHIN_ACESS_TOKEN)
        AppManager.deleteString(AppConstants.KEYCHIN_REFRESH_TOKEN)
        AppManager.deleteString(AppConstants.PREF_USER_TOKEN)
        AppManager.deleteString(AppConstants.PREF_PAYNOW_DATA)
        AppManager.deleteString(AppConstants.PREF_USER_DEVICE_TOKEN)
        AppManager.deleteString(AppConstants.PREF_USER_DEVICE_TOKEN)
        AppManager.deleteDefaultString("userID")
//        AppDelegate.clearUser()
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        AppManager.removeAllKeychain()
    }
    
    static func migrateDataToSharedContainer()
    {
        if let sharedDefaults = UserDefaults.init(suiteName:AppConstants.APP_GROUP)
        {
            for key in UserDefaults.standard.dictionaryRepresentation().keys
            {
                let object = UserDefaults.standard.object(forKey: key)
                sharedDefaults.set(object, forKey: key)
                
                UserDefaults.standard.removeObject(forKey: key)
            }
            
            sharedDefaults.synchronize()
            UserDefaults.standard.synchronize()
        }
        
        let keychain = KeychainSwift()
        if let password = keychain.get(AppConstants.KEYCHIN_PASSWORD)
        {
            self.setToKeychain(AppConstants.KEYCHIN_PASSWORD, value: password)
        }
    }
    
    static func tutorialSeen()
    {
        setString(AppConstants.TUTORIAL_SEEN, value: "TUTORIAL_SEEN")
        return
    }
    
    static func isMerchant() -> Bool
    {
        return AppManager.getBool(AppConstants.PREF_IS_MERCHANT_ACCOUNT)
    }
}

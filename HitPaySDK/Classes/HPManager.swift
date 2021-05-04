//
//  HitPay.swift
//  HitPaySDK
//
//  Created by apple on 4/29/21.
//

import Foundation

public class HPManager: NSObject {
    public static let shared = HPManager() 
    var application: UIApplication?
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.application = application
        self.launchOptions = launchOptions
    }
    
    public func login(_ inViewController: UIViewController) {
        let vc = LoginInputEmailVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        inViewController.present(nav, animated: true, completion: nil)
    }
}

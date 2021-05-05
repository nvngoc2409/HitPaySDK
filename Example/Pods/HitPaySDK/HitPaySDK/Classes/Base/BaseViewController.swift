//
//  BaseViewController.swift
//  HitPay
//
//  Created by DieuH on 19/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

import MBProgressHUD
import SafariServices


class BaseViewController: UIViewController {
    
    lazy var loadingNotification = MBProgressHUD()
    lazy var keyboard = KUIKeyboard()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        HitPayDebugPrint(type(of: self))
    }
    // MARK: - KeyBoard
    
    func addTapDissmisKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - AlertMessage
    
    func showAlertError(titleButton: String? = "OK", message: String? = nil, textFieldBecome: UITextField? = nil) {
        let alert = UIAlertController(title: "Error!", message: message ?? AppConstants.GENERAL_ERROR, preferredStyle: .alert)
        let okAction = UIAlertAction(title: titleButton ?? "OK", style: .default) { action in
            textFieldBecome?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        alert.view.tintColor = .hitpayBlue
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Hub Loading
    
    func startLoading(textLoading: String? = nil, isDimBackground: Bool = false) {
        DispatchQueue.main.async { () -> Void in
            self.loadingNotification = ViewUtil.getHUD(self.view)
            
            if let textLoading = textLoading {
                self.loadingNotification.label.text = textLoading
            }
            
            self.loadingNotification.show(animated: true)
            if isDimBackground == true {
                self.loadingNotification.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            }
        }
    }
    
    func endLoading(_ delay: TimeInterval = 0) {
        DispatchQueue.main.async { () -> Void in
            self.loadingNotification.hide(animated: true, afterDelay: delay)
        }
    }
    
    func showWebWithURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
}

extension UIViewController {
    
    var topBarHeight: CGFloat {
        var value: CGFloat
        if #available(iOS 13.0, *) {
            value = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            value = UIApplication.shared.statusBarFrame.height +
                (navigationController?.navigationBar.frame.height ?? 0)
        }
        
        return value > 20 ? value : 63
    }
    
    func alertBusinessCredentialsMissing(ontapOK:@escaping() -> Void){
        let titleAlert = "Business Credentials Missing"
        let msg = "You need to create a business account to use HitPay app."
        let alertController = UIAlertController(title: titleAlert, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            ontapOK()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func alertWith(tite: String? = nil,
                           msg: String? = nil,
                           ontapOK:@escaping() -> Void) {
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            ontapOK()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y -= keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y += keyboardSize.height
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

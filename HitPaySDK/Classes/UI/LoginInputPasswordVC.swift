//
//  LoginInputPasswordVC.swift
//  HitPay
//
//  Created by DieuH on 29/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

import UIKit

class LoginInputPasswordVC: BaseViewController {
    
    private var email: String?
    
    // MARK: - Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard email != nil else {
            navigationController?.popViewController(animated: true)
            return
        }
        addActionButton()
        addTapDissmisKeyboard()
        txfPassword.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    convenience init(email: String) {
        self.init()
        
        self.email = email
    }
    
    // MARK: - Action button
    
    private func addActionButton() {
        btnLogin.addTarget(self,
                           action: #selector(didTapLoginButton),
                           for: .touchUpInside)
        btnForgotPassword.addTarget(self,
                                    action: #selector(didTapForgotPasswordButton),
                                    for: .touchUpInside)
        btnClose.addTarget(self,
                           action: #selector(didTapCloseButton),
                           for: .touchUpInside)
        btnEye.addTarget(self,
                         action: #selector(didTapEyeButton),
                         for: .touchUpInside)
    }
    
    @objc private func didTapLoginButton() {
        guard let passWord = txfPassword.text, !passWord.isEmpty else {
            showAlertError(message: HitPay.AlertMessage.passWordRequred, textFieldBecome: txfPassword)
            return
        }
        view.endEditing(true)
        startLoading(isDimBackground: true)
        
//        HitPayAPI(viewController: self).loginUser(
//            email: email,
//            passWord: txfPassword.text) { [weak self] (obj, error) in
//                guard let self = self else {return}
//                
//                if let errorMessage = error {
//                    self.endLoading()
//                    self.showAlertError(message: errorMessage)
//                    return
//                }
//                
//                if let obj = obj as? String {
//                    if obj == "Multi-factor" {
//                        self.endLoading()
//                        self.navigationController?.pushViewController(LoginInputCredentialVC(),
//                                                                      animated: true)
//                        return
//                        
//                    } else {
//                        HitPayAPI(viewController: self).getProfileInfo({ (result, errorMessage) in
//                            if let user = result as? User {
//                            AppManager.setString("userID", value: user.id ?? "")
//                            HitPayAPI(viewController: self).checkbusinessesOwned { (objc, errorMSg) in
//                                if errorMSg == nil {
//                                    if let array = objc as? [AnyObject], array.count > 0 {
//                                        DispatchQueue.main.async {
//                                            BaseViewController.setRootViewHome()
//                                        }
//                                    } else {
//                                        self.alertBusinessCredentialsMissing {
//                                            let navi = UINavigationController(rootViewController: SignUpPageTwoVC(email: user.email ?? "", isFromAutoLogin: true))
//                                            navi.modalPresentationStyle = .overFullScreen
//                                            self.present(navi, animated: true)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        })
//                    }
//                }
//        }
    }
    
    @objc override func keyboardWillShow(notification: NSNotification) {
        if UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight{
            self.view.frame.origin.y -= 2 * BaseTextFiled.heightRatio 
        }
    }
    
    @objc override func keyboardWillHide(notification: NSNotification) {
        if UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight{
            self.view.frame.origin.y = 0
            
        }
    }    
    
    @objc private func didTapForgotPasswordButton() {
        view.endEditing(true)
        startLoading()
//        HitPayAPI(viewController: self).forgetPasswordNewAPI(email: email ?? "") {[weak self] (json, errorMsg) in
//            guard let self = self else { return }
//            self.endLoading()
//            if errorMsg == nil {
//                let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
//                ViewUtil.popAlertView(self, title: appName ?? "",
//                                        message: "We have e-mailed your password reset link.",
//                                        option: "Ok")
//            } else {
//                self.showAlertError(message: errorMsg!)
//            }
//        }
    }
    
    @objc private func didTapCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapEyeButton() {
        txfPassword.isSecureTextEntry = !txfPassword.isSecureTextEntry
    }
    
    // MARK: - UI
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(imvBackground)
        view.addSubview(btnClose)
        view.addSubview(imvHitPayLogo)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(lblLogin)
        contentView.addSubview(txfPassword)
        contentView.addSubview(btnEye)
        contentView.addSubview(btnForgotPassword)
        contentView.addSubview(btnLogin)
        
        NSLayoutConstraint.activate([
            // imvBackground
            imvBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imvBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            imvBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            imvBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
            
            // btnClose
            btnClose.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            btnClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            // imvHitPayLogo
            imvHitPayLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 114),
            imvHitPayLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 600/828),
            imvHitPayLogo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 150/1792),
            imvHitPayLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            // scrollView
            scrollView.topAnchor.constraint(equalTo: imvHitPayLogo.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // lblLogin
            lblLogin.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            lblLogin.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: HitPay.Margin.default),
            lblLogin.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -HitPay.Margin.default),
            
            // txfPassword
//            txfPassword.topAnchor.constraint(equalTo: lblLogin.bottomAnchor, constant: 55),
            txfPassword.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -55),
            txfPassword.leftAnchor.constraint(equalTo: lblLogin.leftAnchor),
            txfPassword.rightAnchor.constraint(equalTo: lblLogin.rightAnchor),
            txfPassword.heightAnchor.constraint(equalToConstant: BaseTextFiled.heightRatio),
            
            // btnEye
            btnEye.centerYAnchor.constraint(equalTo: txfPassword.centerYAnchor),
            btnEye.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            btnEye.leftAnchor.constraint(equalTo: txfPassword.rightAnchor),
            btnEye.heightAnchor.constraint(equalToConstant: 44),
            
            // btnForgotPassword
            btnForgotPassword.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnForgotPassword.topAnchor.constraint(equalTo: txfPassword.bottomAnchor, constant: 6),
            btnForgotPassword.heightAnchor.constraint(equalToConstant: HitPay.Size.Height.small),
            
            // btnLogin
            btnLogin.topAnchor.constraint(equalTo: btnForgotPassword.bottomAnchor, constant: 5),
            btnLogin.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnLogin.heightAnchor.constraint(equalTo: txfPassword.heightAnchor),
            btnLogin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            btnLogin.widthAnchor.constraint(equalTo: txfPassword.widthAnchor)
        ])
    }
    
    private let scrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let btnClose: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: ImageName.backButtonTemplate), for: .normal)
        return btn
    }()
    
    private let lblLogin: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Login"
        lbl.font = .sfUITextBold(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let txfPassword: BaseTextFiled = {
        let txf = BaseTextFiled(type: .passWord)
        txf.placeholder = "Enter Password"
        return txf
    }()
    
    private let lblForgotPassword: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Forgot Password"
        lbl.font = UIFont.sfUITextRegular(ofSize: 13)
        return lbl
    }()
    
    private let btnForgotPassword: BaseButton = {
        let btn = BaseButton(style: .none, text: "Forgot Password")
        btn.titleLabel?.font = .sfUITextRegular(ofSize: 13)
        return btn
    }()
    
    private let btnEye: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: ImageName.eye), for: .normal)
        return btn
    }()
    
    private let imvHitPayLogo: UIImageView = {
        let imv = UIImageView(image: UIImage(named: ImageName.hitPayIconText))
        imv.contentMode = .scaleAspectFit
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    private let imvBackground = UIImageView.backgroundLogin()
    private let btnLogin = BaseButton(style: .greenBG, text: "LOGIN")
}


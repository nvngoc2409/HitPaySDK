//
//  LoginInputEmailVC.swift
//  HitPay
//
//  Created by DieuH on 28/12/2019.
//  Copyright © 2019 Ezypayzy. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginInputEmailVC: BaseViewController {
    
    enum StatusLogin: String {
        case emailloginEnabled = "email_login_enabled"
        case stripeAccountFound = "stripe_account_found"
        case accountNotFound = "stripe_account_not_found"
    }
    var isForgotPassword: Bool = false
    // MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        addTapDissmisKeyboard()
        addActionButton()
        if isForgotPassword {
            lblLogin.isHidden = true
        } else {
            lblForgotPassword.isHidden = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        txfEmail.becomeFirstResponder()
    }
    
    // MARK: - Action button
    
    private func addActionButton() {
        btnClose.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapNextButton() {
        guard let email = txfEmail.text, !email.isEmpty else {
            showAlertError(message: HitPay.AlertMessage.emailRequired, textFieldBecome: txfEmail)
            return
        }
        
        view.endEditing(true)
        startLoading(isDimBackground: true)
        ApiService.shared.checkEmail(email: txfEmail.text ?? "") { json, error in
            self.endLoading()
            
            if let error = error {
                self.showAlertError(message: error)
                return
            }
            
            if let json = json, let status = StatusLogin(rawValue: json["status"].stringValue.lowercased()) {
                switch status {
                case .emailloginEnabled:
                    self.navigationController?.pushViewController(LoginInputPasswordVC(email: self.txfEmail.text ?? ""), animated: true)
                case .stripeAccountFound:
                    _ = json["redirect_url"].stringValue
                case .accountNotFound:
                    self.showAlertError(message: "Account not found")
                }
            } else {
                self.showAlertError(message: AppConstants.GENERAL_ERROR)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(imvBackground)
        view.addSubview(btnClose)
        view.addSubview(imvHitPayLogo)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(lblForgotPassword)
        contentView.addSubview(lblLogin)
        contentView.addSubview(txfEmail)
        contentView.addSubview(btnNext)
        
        NSLayoutConstraint.activate([
            // btnClose
            btnClose.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            btnClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            
            // imvHitPayLogo
            imvHitPayLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 114),
            imvHitPayLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 600/828),
            imvHitPayLogo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 150/1792),
            imvHitPayLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // btnClose
            btnClose.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            btnClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            // scrollView
            scrollView.topAnchor.constraint(equalTo: imvHitPayLogo.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // lblLogin
            lblLogin.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            lblLogin.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: HitPay.Margin.default),
            lblLogin.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -HitPay.Margin.default),
            lblLogin.heightAnchor.constraint(equalToConstant: BaseTextFiled.heightRatio),
            
            // lblForgotPassword
            lblForgotPassword.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55),
            lblForgotPassword.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: HitPay.Margin.default),
            lblForgotPassword.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -HitPay.Margin.default),
            
            // txfEmail
            txfEmail.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -55),
            txfEmail.leftAnchor.constraint(equalTo: lblLogin.leftAnchor),
            txfEmail.rightAnchor.constraint(equalTo: lblLogin.rightAnchor),
            txfEmail.heightAnchor.constraint(equalToConstant: BaseTextFiled.heightRatio),
            
            // btnNext
            btnNext.topAnchor.constraint(equalTo: txfEmail.bottomAnchor, constant: 30),
            btnNext.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            btnNext.heightAnchor.constraint(equalTo: txfEmail.heightAnchor),
            btnNext.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            btnNext.widthAnchor.constraint(equalTo: txfEmail.widthAnchor),
            
            // imvBackground
            imvBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imvBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            imvBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            imvBackground.topAnchor.constraint(equalTo: btnNext.bottomAnchor, constant: 50)
            
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
        btn.setImage(UIImage(named: ImageName.btnCloseHitPayBlueColor), for: .normal)
        return btn
    }()
    
    private let lblLogin: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Login"
        lbl.font = .sfUITextBold(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let lblForgotPassword: BaseLabel = {
        let lbl = BaseLabel()
        lbl.text = "Forgot Password"
        lbl.font = .sfUITextBold(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var txfEmail: BaseTextFiled = {
        let txf = BaseTextFiled(type: .email)
        txf.placeholder = "Enter Email Address"
        txf.delegate = self
        return txf
    }()
    
    private let imvBackground = UIImageView.backgroundLogin()
    private let imvHitPayLogo: UIImageView = {
        let imv = UIImageView(image: UIImage(named: ImageName.hitPayIconText))
        imv.contentMode = .scaleAspectFit
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    private let btnNext = BaseButton(style: .greenBG, text: "NEXT")
}

// MARK: - UITextFieldDelegate

extension LoginInputEmailVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string != " "
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else { return false }
        if isForgotPassword {
        } else {
            didTapNextButton()
        }
        return true
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
}

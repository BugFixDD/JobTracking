//
//  ViewController.swift
//  登入界面
//
//  Created by  罗仕宇 on 2018/6/17.
//  Copyright © 2018年 哈. All rights reserved.
//

import UIKit
import SVProgressHUD
import TextFieldEffects

class ETLoginController: UIViewController {

    var close: UIButton!
    var UILable: UILabel!
    var userName = HoshiTextField()
    var password = HoshiTextField()
    var login: UIButton!
    var forgetPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setui()
        view.backgroundColor = UIColor.white
        textChang()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
            
            compute()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        login.gradientLayer.frame = login.bounds
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ETChangeViewControllerNotificationName), object: nil)
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ETChangeViewControllerNotificationName), object: nil)
    }
}



extension ETLoginController {
    @objc func textChang() {
        self.login.isEnabled = !(self.userName.text == "" || self.password.text == "")
            }
    
    @objc func loginOrLogout() {
        ETNetworkingManager.shared.login(userName: userName.text!, password: password.text!) { (isUser, isPass) in
            if isUser == false || isPass == false {
                SVProgressHUD.ET_showLogin(Login: .Error, text: "用户名或密码错误", completion: {
                    
                })
                ETLoginModel.shared.userName = nil
                ETLoginModel.shared.passWord = nil
                ETLoginModel.shared.isLogin = false
            }
            if isUser == true && isPass == true {
                ETLoginModel.shared.userName = self.userName.text
                ETLoginModel.shared.passWord = self.password.text
                ETLoginModel.shared.isLogin = true
                ETLoginModel.shared.save()
                
                SVProgressHUD.ET_showLogin(text: "登入成功", completion: {
                    self.clickClose()
                })

            }
        }
    }
    
 
    
    @objc func clickClose() {
        
        view.endEditing(true)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !userName.isExclusiveTouch || !password.isExclusiveTouch {
            userName.resignFirstResponder()
            password.resignFirstResponder()
        }
    }
}

extension ETLoginController {
    func setui() {
        
        self.close = UIButton()
        self.close.setTitle("关闭", for: [])
        self.close.setTitleColor(UIColor.black, for: [])
        self.close.addTarget(self, action: #selector(clickClose), for: .touchUpInside)
        view.addSubview(close)
        
        
        self.UILable = UILabel()
        self.UILable.text = "请输入账号密码"
        self.UILable.font = UIFont.systemFont(ofSize: 28)
        view.addSubview(self.UILable)
        
        self.userName.borderInactiveColor = UIColor.gray
        self.userName.borderActiveColor = ETBlueColor

        self.userName.placeholder = "用户名"
        self.userName.placeholderFontScale = 0.75
        self.userName.clearButtonMode = UITextFieldViewMode.whileEditing
        self.userName.addTarget(self, action: #selector(textChang), for: UIControlEvents.editingChanged)
        view.addSubview(self.userName)
        
        self.password.borderInactiveColor = UIColor.gray
        self.password.borderActiveColor = ETBlueColor
        self.password.placeholderFontScale = 0.75
        self.password.placeholder = "密码"
        self.password.isSecureTextEntry = true
        self.password.addTarget(self, action: #selector(textChang), for: UIControlEvents.editingChanged)
        self.password.clearButtonMode = UITextFieldViewMode.whileEditing
        view.addSubview(self.password)
        
        self.login = UIButton()
        self.login.setTitle("登入", for: [])
        self.login.setTitleColor(ETSecondBlueTincColor, for: .disabled)
        //self.login.backgroundColor = ETBlueColor
        self.login.addGradientBackgroundColor()
        
        self.login.addTarget(self, action: #selector(loginOrLogout), for: UIControlEvents.touchUpInside)
        view.addSubview(self.login)
        
        compute() 
        
    }
    
    func compute() {
        
        var y: CGFloat = 0
        if #available(iOS 11.0, *) {
            y = view.safeAreaInsets.top + ETContentViewMargin * 1.5
        } else {
            y = ETContentViewMargin * 1.5
        }
        
        
        self.close.frame = CGRect(
            x: ETContentViewMargin,
            y: y ,
            width: 0,
            height: 0)
        self.close.sizeToFit()
        
        self.UILable.frame = CGRect(
            x: ETContentViewMargin,
            y: self.close.frame.maxY + ETContentViewMargin,
            width: ETContentViewWidth,
            height: 50)
        
        self.userName.frame = CGRect(
            x: ETContentViewMargin,
            y: self.UILable.frame.maxY + ETContentViewMargin,
            width: ETContentViewWidth,
            height: 50)
        
        self.password.frame = CGRect(
            x: ETContentViewMargin,
            y: self.userName.frame.maxY + ETContentViewMargin,
            width: ETContentViewWidth,
            height: 50)

        
        self.login.frame = CGRect(
            x: ETContentViewMargin,
            y: self.password.frame.maxY + self.userName.frame.height,
            width: ETContentViewWidth,
            height: 40)
        self.login.layer.cornerRadius = 5
        self.login.layer.masksToBounds = true
    }
}

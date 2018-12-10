//
//  ETEmploymentProtocol.swift
//  九江职业技术学院就业跟踪
//
//  Created by 树清吴 on 2018/6/17.
//  Copyright © 2018年 BF. All rights reserved.
//

import UIKit
import SVProgressHUD
import TextFieldEffects

/// 上传就业协议控制器
class ETEmploymentProtocol: UIViewController {

    /// 内容的View
    @IBOutlet weak var contentVw: UIView!
    /// 协议书编号
    @IBOutlet weak var bookNumberTextF: UITextField!
    /// 组织机构代码
    @IBOutlet weak var codeTextF: UITextField!
    /// 单位名称
    @IBOutlet weak var firmNameTextF: UITextField!
    ///  单位名称
    @IBOutlet weak var firmNatureTextF: UITextField!
    /// 协议书imageView
    @IBOutlet weak var imgView: UIImageView!
    /// 选择协议书图片按钮
    @IBOutlet weak var selectImgBtn: UIButton!
    
    /// 上传按钮
    @IBOutlet weak var uploadBtn: UIButton!
    
    /// 选取图片
    lazy var pickerVC = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        pickerVC.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        uploadBtn.gradientLayer.frame = uploadBtn.bounds
    }
    
    //MARK: 监听键盘弹出事件
    @objc func keyboardChangeFrame() {
        navigationItem.rightBarButtonItem?.customView?.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: 按钮监听方法
    @IBAction func selectBtnClick(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: "选择图片", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "照相机拍摄", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
                return
            }
            
            self.pickerVC.sourceType = .camera
            self.present(self.pickerVC, animated: true, completion: nil)
        }
        let albumAction = UIAlertAction(title: "本地相册", style: .default) { (action) in
            

            self.pickerVC.sourceType = .photoLibrary
            self.present(self.pickerVC, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(albumAction)
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func uploadBtnClick(_ sender: UIButton) {
        if checkIsEmpty() == true {
            return
        }
        
        SVProgressHUD.ET_showSucceed(text: "上传成功") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// 完成按钮的点击事件
    @objc func doneBtnClick(sender: UIButton) {
        view.endEditing(true)
        
        sender.isHidden = true
    }
    
    /// 判断是否有信息没填
    ///
    /// - Returns: 返回true表示有信息没填
    func checkIsEmpty() -> Bool {
        
        if bookNumberTextF.hasText == false {
            SVProgressHUD.ET_showEmptyInfo(text: "协议书编号")
            return true
        }
        if codeTextF.hasText == false {
            SVProgressHUD.ET_showEmptyInfo(text: "组织机构代码")
            return true
        }
        if firmNameTextF.hasText == false {
            SVProgressHUD.ET_showEmptyInfo(text: "单位名称")
            return true
        }
        if firmNatureTextF.hasText == false {
            SVProgressHUD.ET_showEmptyInfo(text: "单位行业")
            return true
        }
        // TODO:判断是否选择图片
        // 判断是否选择图片
        if imgView.image == nil {
            SVProgressHUD.ET_showEmptyInfo(text: "协议书照片")
            return true
        }
        
        return false
    }
    
}

extension ETEmploymentProtocol: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let img = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        if pickerVC.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        }
        
        imgView.image = img
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - 设置UI
extension ETEmploymentProtocol {
    func setupUI() {
        let radius: CGFloat = 5
        uploadBtn.layer.cornerRadius = radius
        uploadBtn.addGradientBackgroundColor()
        uploadBtn.backgroundColor = nil
        
        contentVw.layer.cornerRadius = radius
        contentVw.layer.shadowColor = UIColor.gray.cgColor
        contentVw.layer.shadowOffset = CGSize(width: 5, height: 5)
        contentVw.layer.shadowOpacity = 1
        
        let btn = UIButton(type: .system)
        btn.setTitle("完成", for: .normal)
        btn.addTarget(self, action: #selector(doneBtnClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        btn.isHidden = true
        
        
    }
}

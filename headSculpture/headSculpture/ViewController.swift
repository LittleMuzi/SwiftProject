//
//  ViewController.swift
//  headSculpture
//
//  Created by 幸福的小木子 on 2017/2/11.
//  Copyright © 2017年 xiaomuzi. All rights reserved.
//

import UIKit
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var headSculpture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupView()
    }
    //MARK:搭建视图
    func setupView(){
        self.view.backgroundColor = UIColor.white
        let btn = UIButton(frame: CGRect(x: screenWidth/2-100, y: 100, width: 200, height: 40))
        btn.layer.cornerRadius = 20
        btn.backgroundColor = UIColor.orange
        btn.setTitle("设置头像", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(setHeadSculpture), for: .touchUpInside)
        self.view.addSubview(btn)
        
        //头像视图
        headSculpture = UIImageView(frame: CGRect(x: screenWidth/2-50, y: screenHeight/2-50, width: 100, height: 100))
        //使用CAShapeLayer和UIBezierPath画圆性能更好点,可以参考一下这个http://www.jianshu.com/p/e97348f42276
        let path = UIBezierPath(roundedRect: headSculpture.bounds, byRoundingCorners: .allCorners, cornerRadii: headSculpture.bounds.size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = headSculpture.bounds
        maskLayer.path = path.cgPath
        headSculpture.layer.mask = maskLayer
        self.view.addSubview(headSculpture)
    }
    func setHeadSculpture(){
        let alert = UIAlertController(title: "上传头像", message: "", preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "相册", style: .default) { (_) in
            //调用相册功能，打开相册
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }
        let camera = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction) -> Void in
            //判断是否能进行拍照，可以的话打开相机
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
                
            }
            else
            {
                let warning = UIAlertController(title: "相机不可用", message: "你未允许应用访问你的相机或相机不可用", preferredStyle: .alert)
                let know = UIAlertAction(title: "我知道了", style: .default, handler: nil)
                warning.addAction(know)
                self.present(warning, animated: true, completion: nil)
            }
        })
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(photo)
        alert.addAction(camera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    //选取图片方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //显示的图片
        let image:UIImage!
        //获取选择的原图
        //使用编辑后的图：UIImagePickerControllerEditedImage,原图：UIImagePickerControllerOriginalImage
        image = info[UIImagePickerControllerEditedImage] as! UIImage
        self.headSculpture.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    //图片选取成功后返回页面
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

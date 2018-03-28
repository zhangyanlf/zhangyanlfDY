//
//  UIBarbuttonItem+Extension.swift
//  zhangyanlfDY
//
//  Created by 张彦林 on 2018/3/27.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    /**
    class func createItem(imageName: String, highImageName: String, size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    
    /// 便利函数 1>convenience开头  2>在构建函数过程中必须明确调用一个设计的构造函数（self）
    ///
    /// - Parameters:
    ///   - imageName: 默认图片
    ///   - highImageName: 高亮图片
    ///   - size: 大小
    convenience init(imageName: String, highImageName: String = "", size:CGSize = CGSize.zero) {
    
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != ""{
            btn.setImage(UIImage(named:highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
             btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //创建UIBarButtonItem
        self.init(customView: btn)
    }
}
